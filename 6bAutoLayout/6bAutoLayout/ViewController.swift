//
//  ViewController.swift
//  6bAutoLayout
//
//  Created by Subramanian, Vishwanath on 6/24/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.redColor()
        
        label1.text = "THESE"
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyanColor()
        label2.text = "ARE"
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellowColor()
        label3.text = "SOME"
        
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.greenColor()
        label4.text = "AWESOME"
        
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orangeColor()
        label5.text = "LABELS"
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = ["label1": label1, "label2": label2, "label3" : label3, "label4": label4, "label5": label5]
        
        for label in viewsDictionary.keys {
            
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H: |[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
            
            
        }
        
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

