//
//  ViewController.swift
//  13Instafilter
//
//  Created by Subramanian, Vishwanath on 7/25/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

// once you assign the VC to be the image picker's delegate, you will get warnings that we dont conform to the correct protocls. Fix by changing the view controllers class definition to this

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var Intensity: UISlider!
    
    
    var currentImage: UIImage!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "YACIFP"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(importPicture))
        
        
        
        
        
        
        
        
        
        
    }
    
    func importPicture() {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
    //Need to implement twp methods to make the image picker useful, one for when the user pressed cancel and one for when they selected a picture
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
            
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        
        dismissViewControllerAnimated(true, completion: nil)
        //set our current image to bethe one selected in the image picker so that we can have a copy of what was originally imported
        currentImage = newImage
        
        
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func changeFilter(sender: AnyObject) {
    }
    
    
    @IBAction func save(sender: AnyObject) {
    }
    
    
    @IBAction func intensityChanged(sender: AnyObject) {
    }
    
    
}

