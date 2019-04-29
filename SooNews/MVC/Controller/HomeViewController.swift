//
//  HomeViewController.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Kingfisher

class HomeViewController: UIViewController{
    // MARK: - OUTLETS DECLARATIONS
    @IBOutlet weak var newsArticleTableView: UITableView!
    
    // MARK: - VARIABLE DECLARATIONS
    let searchController = UISearchController(searchResultsController: nil)
    var articleDataArray = [NewsDataModelArticle]()
    var filterArticleArray = [NewsDataModelArticle]()
    let noCache : String = "no-cache"
    let applicationJon : String = "application/json"
    let search = "Today's Highlights"
    let newsArticlesTableViewCellIdentifier = "NewsArticlesTableViewCell"
    let webViewControllerIdentifier = "WebViewController"
    let mainThread = DispatchQueue.main
    let cellSize : CGFloat = 280
    
    //MARK: - LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        initialisingView()
        getDelegates()
        tableCellRegistration()
        setUpSearchBar()
        fetchNewsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: - CLASS BEHAVIOR
    
    // initialising view controller with necessary UI Updates
    func initialisingView(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.title = search
        
        newsArticleTableView.separatorStyle = .none
        newsArticleTableView.tableFooterView = UIView()
    }
    
    // getting delegates of tableview and searchController
    func getDelegates(){
        newsArticleTableView.delegate = self
        newsArticleTableView.dataSource = self
        searchController.searchResultsUpdater = self
    }
    
    // table cell registration with HomeSearchTableView
    func tableCellRegistration(){
        
        let cellNib = UINib(nibName: newsArticlesTableViewCellIdentifier, bundle: nil)
        newsArticleTableView.register(cellNib, forCellReuseIdentifier: newsArticlesTableViewCellIdentifier)
    }
    
    // Setting up searchController and providing neccessary updates
    func setUpSearchBar(){
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: - NETWORK CALLS
    func fetchNewsData(){
        
        ActivityIndicator.shared.showProgressView(self.view)
        
        let header = [Key.Headers.cacheControl : noCache,Key.Headers.contentType : applicationJon]
        
        Service().serviceCall(headers: header, url: APPURL.NewsApi, httpMethod: Key.getHttpMethod, success: {
            // Success Closure
            successJson in
            // saving success response in data variable
            let data = NewsDataModelRootClass.init(fromJson: successJson)
            
            // fetching values from data variables and storing in articleDataArray
            data.articles.forEach({ (article) in
                self.articleDataArray.append(article)
            })
            // getting data into filterArticleArray
            self.filterArticleArray = self.articleDataArray
            
            // using main thread to reload table view and dismiss loader from screen
            self.mainThread.async {
                ActivityIndicator.shared.hideProgressView();                self.newsArticleTableView.reloadData()
            }
        }, failure: {
            // failure Closure
            error in
            // shifting to main to dismiss loader from screen and showing alert
            self.mainThread.async {
                ActivityIndicator.shared.hideProgressView()
                let alert = AlertController().showAlert(title: Key.failure, message: "\(error)\nTry again?", completion: {
                    self.fetchNewsData()
                })
                self.present(alert, animated: true, completion: nil)
            }
            
        })
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}

// using extension for handling delegate functions
extension HomeViewController : UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating{
    //MARKS: - DELEGATE METHODS
    
    // search bar delegate mnethod
    func updateSearchResults(for searchController: UISearchController) {
        
        filterArticleArray = articleDataArray.filter({ (newsDataModelArticle) -> Bool in
            if searchBarIsEmpty() {
                return (newsDataModelArticle.source!.name != nil)
            }else{
                return newsDataModelArticle.source.name.contains(searchController.searchBar.text!.capitalized)
            }
        })
        self.newsArticleTableView.reloadData()
    }
    // table view delegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellSize
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArticleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : NewsArticlesTableViewCell = tableView.dequeueReusableCell(withIdentifier: newsArticlesTableViewCellIdentifier, for: indexPath) as! NewsArticlesTableViewCell
        let imageUrl = URL(string: filterArticleArray[indexPath.row].urlToImage)
        cell.articleThumbnailImageView.kf.setImage(with:  imageUrl,placeholder: UIImage.init(named: "placeholder-image"))
        cell.articleTitleLabel.text = filterArticleArray[indexPath.row].title
        cell.sourceNameLabel.text = filterArticleArray[indexPath.row].source.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        below code is used to load url into safari
        //        guard let url = URL(string: filterArticleArray[indexPath.row].url) else { return }
        //        UIApplication.shared.open(url)
        
        //        below code is used to push new view controller
        let webViewController = self.storyboard?.instantiateViewController(withIdentifier: webViewControllerIdentifier) as! WebViewController
        webViewController.articleObject = filterArticleArray[indexPath.row]
        navigationController?.pushViewController(webViewController, animated: true)
    }
}

