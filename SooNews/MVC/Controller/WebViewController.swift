//
//  WebViewController.swift
//  SooNews
//
//  Created by Kishan Gupta on 26/04/19.
//  Copyright © 2019 KishanGupta. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var newsWebview: WKWebView!
    
    var articleObject : NewsDataModelArticle?
    
    //MARK: - LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialiseView()
        getDelegate()
        loadWebView()
    }
    
    //MARK: - CLASS BEHAVIOR
    func initialiseView(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = articleObject?.source.name
    }
    
    func getDelegate(){
        newsWebview.navigationDelegate = self
    }
    
    func loadWebView(){
        let url = URL(string: self.articleObject!.url)
        newsWebview.load(URLRequest(url: url!))
        newsWebview.allowsBackForwardNavigationGestures = true
    }
}
extension WebViewController: WKNavigationDelegate{
    //MARK: - DELEGATE MATHODS
    // Observe value to show on progress bar
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.progress = Float(self.newsWebview.estimatedProgress);
        }}
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loadWebView()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //add observer to get estimated progress value
        progressView.progress = Float(0.0)
        self.newsWebview.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
}
