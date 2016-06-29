//
//  DetailViewController.swift
//  7WhitehousePetitions
//
//  Created by Subramanian, Vishwanath on 6/27/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        
        webView = WKWebView()
        view = webView
    }


    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
}

