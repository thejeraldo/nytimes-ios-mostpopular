//
//  ArticleViewModel.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import Foundation

struct ArticleViewModel {
  let article: Article
  
  let titleText: String
  let bylineText: String
  let sectionText: String
  var dateText: String
  let abstractText: String
  var thumbnailImageURL: URL?
  var detailImageURL: URL?
  
  static func dateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d yyyy"
    return dateFormatter
  }
  
  init(article: Article) {
    self.article = article
    titleText = article.title ?? ""
    bylineText = article.byline ?? ""
    sectionText = article.section ?? ""
    dateText = ""
    if let publishDate = article.publishedDate {
      dateText = ArticleViewModel.dateFormatter().string(from: publishDate)
    }
    abstractText = article.abstract ?? ""
    
    // Images
    if let mediaMetadata: [MediaMetaData] = article.media?.first?.mediaMetadata {
      let square320 = mediaMetadata.filter { $0.format == "square320" }
      if let thumbnailURL = square320.first?.url {
        thumbnailImageURL = URL(string: thumbnailURL)
      }
      let superJumbo = mediaMetadata.filter { $0.format == "superJumbo" }
      if let detailURL = superJumbo.first?.url {
        detailImageURL = URL(string:detailURL)
      }
    }
  }
}
