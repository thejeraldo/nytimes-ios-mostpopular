//
//  WebServiceProtocol.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
  case GET    = "GET"
  case POST   = "POST"
  case put    = "PUT"
  case patch  = "PATCH"
  case delete = "DELETE"
}

typealias Parameters = [String : Any]
typealias HTTPHeaders = [String : String]

protocol WebServiceProtocol {
  var baseURL: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var parameters: Parameters { get }
  var headers: HTTPHeaders { get }
}
