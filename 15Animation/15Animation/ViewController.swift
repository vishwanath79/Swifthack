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
        // when method begins hide tap button so animations dont collide
        tap.hidden = true
        //call below method with duration of 1 second, no delay and no interesting options
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
                                   //for closure we do the usual [unowned self] to avoid strong reference cycles
                                   animations: { [unowned self] in
                                    switch self.currentAnimation {
                                        
                                    case 0 :
                                        self.imageView.transform = CGAffineTransformMakeScale(2,2)
                                    
                                    case 1 :
                                        //this clears our view of any pre-defined treansform resetting any changes
                                        
                                        self.imageView.transform = CGAffineTransformIdentity
                                        
                                    case 2 :
                                        self.imageView.transform = CGAffineTransformMakeTranslation(-256,-256)
                                    
                                    case 3:
                                        self.imageView.transform = CGAffineTransformIdentity
                                        
                                    case 4 :
                                        self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                                        
                                    case 5:
                                        self.imageView.transform = CGAffineTransformIdentity
                                        
                                        
                                    case 6:
                                        self.imageView.alpha = 0.1
                                        self.imageView.backgroundColor = UIColor.greenColor()
                                        
                                        
                                    case 7:
                                        self.imageView.backgroundColor = UIColor.clearColor()
                                        
                                    default:
                                        break
                                        
                                    }
                                    
                                    
        }) { [unowned self] (finished: Bool) in
            self.tap.hidden = false
            //completion unhides the tap button
        }
        
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

