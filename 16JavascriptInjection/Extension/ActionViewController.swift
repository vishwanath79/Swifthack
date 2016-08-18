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

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // when extension is created, extensioncontext lets us control how it interacts with the parent app
        //in the case of inputitems this will be an array of data that the parent app is sending to our extension to use
        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                //ask the item provider to actually provide us with the item, it uses a closure so its executes the code asynchronously i.e method will carry on while item provider is busy loading and sending the data
                
                // in locsure we need unowned self to avoid strong reference cycles
                itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil) {[unowned self] (dict,error) in
                
               let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
                    
                    print(javaScriptValues)
        }
    
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}
