//
//  ArticleDetailViewController.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import UIKit
import SVProgressHUD

class ArticleDetailViewController: UITableViewController {
  
  var articleViewModel: ArticleViewModel?
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var imageViewHeight: NSLayoutConstraint?
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bylineLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var abstractLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = articleViewModel?.sectionText
    setupTableView()
    updateUI()
  }
  
  func setupTableView() {
    tableView.rowHeight = tableView.frame.width / (16/9)
    tableView.estimatedRowHeight = tableView.frame.width / (16/9)
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
  }
  
  func updateUI() {
    if let detailImage = articleViewModel?.detailImageURL?.absoluteString {
      imageView.loadImageUsingUrlString(urlString: detailImage)
      imageViewHeight?.constant = imageView.frame.width / (16/9)
      imageView.layoutIfNeeded()
    }
    titleLabel.text = articleViewModel?.titleText
    bylineLabel.text = articleViewModel?.bylineText
    dateLabel.text = articleViewModel?.dateText
    abstractLabel.text = articleViewModel?.abstractText
  }
  
  @IBAction func readFull() {
    if let articleURL = articleViewModel?.article.url {
      if let url = URL(string: articleURL) {
        if UIApplication.shared.canOpenURL(url) {
          UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
          let alert = UIAlertController(title: "Unable to open the link to the article", message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 7
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 1 {
      let height = tableView.frame.width / (16/9)
      if height <= 1365 { return height } else { return 1365 }
    }
    if indexPath.row == 5 {
      return 44
    }
    return UITableViewAutomaticDimension
  }
  
  // MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
