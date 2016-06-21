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
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
       navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: #selector(openTapped))
       progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer,refresh]
        navigationController?.toolbarHidden = false
        
        
       //let url = NSURL(string: "https://hackingwithswift.com")
        let url = NSURL(string: "https://" + websites[0])!
       webView.loadRequest(NSURLRequest(URL: url))
       webView.allowsBackForwardNavigationGestures = true
        
              webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
    
        for website in websites {
            
            ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        
    
        ac.addAction(UIAlertAction(title:"Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.URL
        
        if let host = url!.host {
        for website in websites {
        
        if host.rangeOfString(website) != nil {
        
        decisionHandler(.Allow)
        return
                }
        }
        
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

