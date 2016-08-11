//
//  ViewController.swift
//  15Animation
//
//  Created by Subramanian, Vishwanath on 8/10/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tap: UIButton!
    
    
    @IBAction func tapped(sender: AnyObject) {
        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
    
    var imageView: UIImageView!
    var currentAnimation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use an initializer that takes a UIImage and makes the image view the size for the image
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x:512, y:384)
        view.addSubview(imageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

