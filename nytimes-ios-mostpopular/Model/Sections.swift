//
//  Sections.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation

struct Sections: Codable {
  let message: String?
  let results: [Section]
}

struct Section: Codable {
  let name: String
}
