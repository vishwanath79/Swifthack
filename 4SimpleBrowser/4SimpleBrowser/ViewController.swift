//
//  ViewController.swift
//  4SimpleBrowser
//
//  Created by Subramanian, Vishwanath on 6/18/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import WebKit

//The interesting stuff comes next: there's a colon, followed by UIViewController, then a comma and WKNavigationDelegate. 
//If you're feeling fancy, this part is called a type inheritance clause
//What it really means is that this is the definition of what the new ViewController class is made of: it inherits from UIViewController (the first item in the list), and implements the WKNavigationDelegate

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: #selector(openTapped))
        let url = NSURL(string: "https://hackingwithswift.com")
        webView.loadRequest(NSURLRequest(URL: url!))
        webView.allowsBackForwardNavigationGestures = true
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "apple.com", style: .Default, handler: openPage))
        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .Default, handler: openPage))
        ac.addAction(UIAlertAction(title:"Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

