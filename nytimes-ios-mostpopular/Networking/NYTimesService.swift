//
//  NYTimesService.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation
import Alamofire

struct NYTimesService {
  var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
  }
  
  var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .formatted(self.dateFormatter)
    return decoder
  }
  
  func getSections(completion: @escaping (_ sections: Sections?, _ error: Error?) -> ()) {
    Alamofire.request(NYTimesAPI.getSections()).responseJSON { (response) in
      switch response.result {
      case .success(_):
        let result = try? self.decoder.decode(Sections.self, from: response.data!)
        completion(result, nil)
      case .failure(let error):
        completion(nil, error)
      }
    }
  }
  
  func getMostPopularForSection(_ section: String, timePeriod: MostPopularTimePeriod, completion: @escaping (_ mostPopular: MostPopular?, _ error: Error?) -> ()) {
    Alamofire.request(NYTimesAPI.getMostPopularForSection(section, timePeriod: timePeriod)).responseJSON { (response) in
      switch response.result {
      case .success(_):
        let result = try? self.decoder.decode(MostPopular.self, from: response.data!)
        completion(result, nil)
      case .failure(let error):
        completion(nil, error)
      }
    }
  }
}
