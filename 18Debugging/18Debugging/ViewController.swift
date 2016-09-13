//
//  ViewController.swift
//  18Debugging
//
//  Created by Subramanian, Vishwanath on 9/12/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(1,2,3,4,5, separator: "=")
        print("Some message", terminator: "")
        
        for i in 1 ... 100 {
            print("Got number \(i)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

