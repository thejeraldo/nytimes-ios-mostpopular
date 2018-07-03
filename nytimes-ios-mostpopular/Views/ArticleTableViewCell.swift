//
//  ArticleTableViewCell.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
  
  @IBOutlet weak var thumbnailImageView: UIImageView! {
    didSet {
      thumbnailImageView.clipsToBounds = true
      thumbnailImageView.layer.borderColor = UIColor.black.cgColor
      thumbnailImageView.layer.borderWidth = 0.5
      thumbnailImageView.layer.cornerRadius = 2
    }
  }
  @IBOutlet weak var articleTitleLabel: UILabel!
  @IBOutlet weak var bylineLabel: UILabel!
  @IBOutlet weak var sectionLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  func configureWith(viewModel: ArticleViewModel) {
    if let thumbnail = viewModel.thumbnailImageURL?.absoluteString {
      thumbnailImageView.loadImageUsingUrlString(urlString: thumbnail)
    }
    articleTitleLabel.text = viewModel.titleText
    bylineLabel.text = viewModel.bylineText
    sectionLabel.text = viewModel.sectionText
    dateLabel.text = viewModel.dateText
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
