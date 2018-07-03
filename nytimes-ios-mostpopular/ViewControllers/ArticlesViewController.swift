//
//  ArticlesViewController.swift
//  nytimes-ios-mostpopular
//
//  Created by Jeraldo Abille on 7/3/18.
//  Copyright © 2018 thejeraldo. All rights reserved.
//

import UIKit
import SVProgressHUD

class ArticlesViewController: UIViewController {
  
  var articles = [Article]()
  var section: String = "all-sections"
  var period: MostPopularTimePeriod = .week
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      let nib = UINib(nibName: "ArticleTableViewCell", bundle: Bundle.main)
      tableView.register(nib, forCellReuseIdentifier: "articleCell")
      tableView.dataSource = self
      tableView.delegate = self
      let refreshControl = UIRefreshControl()
      refreshControl.addTarget(self, action: #selector(loadArticles), for: .valueChanged)
      tableView.refreshControl = refreshControl
      tableView.tableFooterView = UIView()
      tableView.estimatedRowHeight = 100
      tableView.rowHeight = UITableViewAutomaticDimension
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Most Popular"
    self.splitViewController?.delegate = self
    self.splitViewController?.preferredDisplayMode = .allVisible
    
    let menuBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(showMenu))
    navigationItem.rightBarButtonItem = menuBarButtonItem
    
    loadArticles()
  }
  
  @objc func loadArticles() {
    SVProgressHUD.show()
    let service = NYTimesService()
    service.getMostPopularForSection(section, timePeriod: period) { (mostPopular, error) in
      self.tableView.refreshControl?.endRefreshing()
      guard error == nil else {
        SVProgressHUD.showError(withStatus: "Unable to load articles.")
        return
      }
      
      if let message = mostPopular?.message {
        SVProgressHUD.showError(withStatus: message)
        return
      }
      
      SVProgressHUD.dismiss()
      if let results = mostPopular?.results {
        self.articles = results
        self.tableView.reloadData()
      }
    }
  }
  
  @objc func showMenu() {
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - UITableViewDataSource

extension ArticlesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleTableViewCell
    let article = self.articles[indexPath.row]
    let articleViewModel = ArticleViewModel(article: article)
    cell.configureWith(viewModel: articleViewModel)
    return cell
  }
}

// MARK: - UITableViewDelegate

extension ArticlesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let article = self.articles[indexPath.row]
    let articleViewModel = ArticleViewModel(article: article)
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as! ArticleDetailViewController
    vc.articleViewModel = articleViewModel
    splitViewController?.showDetailViewController(vc, sender: self)
  }
}

// MARK: - UISplitViewControllerDelegate

extension ArticlesViewController: UISplitViewControllerDelegate {
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
    guard let topAsDetailController = secondaryAsNavController.topViewController as? ArticleDetailViewController else { return false }
    if topAsDetailController.articleViewModel == nil {
      return true
    }
    return false
  }
}
