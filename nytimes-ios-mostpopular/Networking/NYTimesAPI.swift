//
//  NYTimesAPI.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation
import Alamofire

enum MostPopularTimePeriod: String {
  case day    = "1"
  case week   = "7"
  case month  = "30"
}

enum NYTimesAPI {
  case getSections()
  case getMostPopularForSection(String, timePeriod: MostPopularTimePeriod)
  
  var apiKey: String {
    return "5bcd7c7c9bf746089afa6924facf90d9"
  }
}

extension NYTimesAPI: WebServiceProtocol, URLRequestConvertible  {
  var baseURL: URL {
    return URL(string: "https://api.nytimes.com")!
  }
  
  var path: String {
    switch self {
    case .getSections():
      return "svc/mostpopular/v2/viewed/sections.json"
    case let .getMostPopularForSection(section, timePeriod: timePeriod):
      return "svc/mostpopular/v2/mostviewed/\(section)/\(timePeriod.rawValue).json"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getSections(), .getMostPopularForSection(_, timePeriod: _):
      return .GET
    }
  }
  
  var parameters: Parameters {
    return [:]
  }
  
  var headers: HTTPHeaders {
    return ["api-key" : apiKey]
  }
  
  func asURLRequest() throws -> URLRequest {
    var request = URLRequest(url: baseURL.appendingPathComponent(self.path))
    request.httpMethod = self.method.rawValue
    request.allHTTPHeaderFields = self.headers
    return try URLEncoding.methodDependent.encode(request, with: self.parameters)
  }
}
