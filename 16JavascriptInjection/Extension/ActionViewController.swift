//
//  ActionViewController.swift
//  Extension
//
//  Created by Subramanian, Vishwanath on 8/17/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    var pageTitle = ""
    var pageURL = ""
    

    

    

    @IBOutlet var script: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(done))
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIKeyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
        // when extension is created, extensioncontext lets us control how it interacts with the parent app
        //in the case of inputitems this will be an array of data that the parent app is sending to our extension to use
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                //ask the item provider to actually provide us with the item, it uses a closure so its executes the code asynchronously i.e method will carry on while item provider is busy loading and sending the data
                
                // in locsure we need unowned self to avoid strong reference cycles
                itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil) {[unowned self] (dict,error) in
                
               let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    
                    self.pageTitle = javaScriptValues["title"] as! String
                    self.pageURL = javaScriptValues["URL"] as! String
                    // uses dispatch_asycn() to set the view controllers title property on the main queue
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                    self.title = self.pageTitle
                        
                    
                    }
                    
                    
    
            }
        }
    }

    }
    
    func adjustForKeyboard(notification: NSNotification) {
        
        
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let keyboardViewEndFrame = view.convertRect(keyboardScreenEndFrame, fromView: view.window)
        
        if notification.name == UIKeyboardWillHideNotification {
            script.contentInset = UIEdgeInsetsZero
        }
        
        else {
            
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        //calling completerequestreturningitems on our extension context will cause the extension to be closed
        // code required to send the data back to safari at which point it will appear inside the finalize function in action.js.
        //we pull the custom JS value out of the parameters array then pass it to the javascript eval() which executes any code it finds
        let item = NSExtensionItem()
        let webDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: ["customJavaScript": script.text]]
        let customJavaScript = NSItemProvider(item: webDictionary,typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        extensionContext!.completeRequestReturningItems([item], completionHandler: nil)
        
        
        
    }

}
