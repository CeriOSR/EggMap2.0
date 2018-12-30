//
//  WebViewController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-28.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate{
    
    let webView: WKWebView = {
        let wv = WKWebView()
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "http://xbo-m.com") else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    override func loadView() {
        super.loadView()
        webView.navigationDelegate = self
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(webView)
        webView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}
