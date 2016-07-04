//
//  ViewController.swift
//  7Swiftywords
//
//  Created by Subramanian, Vishwanath on 7/3/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cluesLabel: UILabel!
    
    @IBOutlet var answersLabel: UILabel!
    
    
    @IBOutlet var currentAnswer: UITextField!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBAction func submitTrapped(sender: AnyObject) {
    }
    
    
    @IBAction func clearTapped(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

