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
    
    // Core image context which is the core image component that handles rendering Creating a context is computationally expensive so we dont want to keep doing it
        var context: CIContext!
    
    //CIF will store whatever filter we have activated
    var currentFilter: CIFilter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "YACIFP"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(importPicture))
        
        
        
        
        
        
        context = CIContext(options: nil)
        // creates a default impage context then creates an example filter that will apply a sepia tone effect to images
        currentFilter = CIFilter(name: "CISepiaTone")
        
        
        
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
     
        let beginImage = CIImage(image: currentImage)
        //we're going to let users frag the slider up and down to add varying amounts of sepia effect to the image they select.
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        //we create a CIImage from a UIImage and we send the result into the current core image filter using KCIInputImageKey
        
      
        applyProcessing()
        
        
    }
    
    
    func applyProcessing() {
        
        // uses value of our intensity slider to set kCIIInputIntensitykey value of our current core image filter
        
        currentFilter.setValue(Intensity.value, forKey: kCIInputIntensityKey)
        
        // creates new datatype called CGImage from output image of the current filter. Using currentFilter.outputImage! means render all parts of the image
        let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        
        //creates new UIImage from CGImage
        let processedImage = UIImage(CGImage: cgimg)
        
        //assign to imageView
        imageView.image = processedImage
        
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func changeFilter(sender: AnyObject) {
        
        let ac = UIAlertController(title: "choose filter", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CIGuassianBlur", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: .setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func save(sender: AnyObject) {
    }
    
      // we need to call the applyprocessing method when the slider is dragged around
    @IBAction func intensityChanged(sender: AnyObject) {
        applyProcessing()
    }
    
    
}

