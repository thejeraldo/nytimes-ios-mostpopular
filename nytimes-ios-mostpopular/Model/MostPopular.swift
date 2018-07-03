//
//  MostPopular.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation

struct MostPopular: Codable {
  let message: String?
  let results: [Article]
}

struct Article: Codable {
  let url: String?
  let section: String?
  let byline: String?
  let title: String?
  let abstract: String?
  let publishedDate: Date?
  let source: String?
  let assetId: Int?
  let media: [Media]?
}

struct Media: Codable {
  let type: String?
  let subtype: String?
  let caption: String?
  let copyright: String?
  let mediaMetadata: [MediaMetaData]?
  
  enum CodingKeys: String, CodingKey {
    case type
    case subtype
    case caption
    case copyright
    case mediaMetadata = "media-metadata"
  }
}

struct MediaMetaData: Codable {
  let url: String?
  let format: String?
  let height: Int?
  let width: Int?
}



