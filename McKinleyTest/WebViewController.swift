//
//  WebViewController.swift
//  McKinleyTest
//
//  Created by Abhishek on 19/12/19.
//  Copyright © 2019 Evontech. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    static let storyboardID = "myWebView"
    var webView: WKWebView!
    var urlToLoad: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        view = webView
        loadWebView()
        // Do any additional setup after loading the view.
    }
    
    //loading webview
    func loadWebView(){
        let token = UserDefaults.standard.string(forKey: "token")
        let url = URL(string: "https://www.hackingwithswift.com?token=\(token!)")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
