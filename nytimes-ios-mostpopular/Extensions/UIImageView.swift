//
//  UIImageView.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
  func loadImageUsingUrlString(urlString: String) {
    guard let url = URL(string: urlString) else {
      return
    }
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
      self.image = imageFromCache
      return
    } else {
      image = nil
    }
    
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      guard error == nil else {
        print("Error downloading image. \(error!)")
        return
      }
      DispatchQueue.main.async {
        let imageToCache = UIImage(data: data!)
        imageCache.setObject(imageCache, forKey: urlString as AnyObject)
        self.image = imageToCache
      }
      }.resume()
  }
}
