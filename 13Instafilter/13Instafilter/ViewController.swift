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
        
        // using this methdo we check each of our four keys to see whether the current fitler supports it and if so we set the value.
        
        // uses value of our intensity slider to set kCIIInputIntensitykey value of our current core image filter
        
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(Intensity.value, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(Intensity.value * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(Intensity.value * 10, forKey: kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width/2,y:currentImage.size.height / 2), forKey: kCIInputCenterKey) }
        
        let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        let processedImage = UIImage(CGImage: cgimg)
        
        self.imageView.image = processedImage
        
    }
    
        
        
 
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func setFilter(action: UIAlertAction!) {
        
        currentFilter = CIFilter(name: action.title!)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    @IBAction func changeFilter(sender: AnyObject) {
        
        // when tapped each of the fitler buttons will call the setfilter() method
        //THis method should update our currentFilter property with the filter that was chosen
        
        let ac = UIAlertController(title: "choose filter", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGuassianBlur", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    //method takes 4 parameters, image to write, who to tell when writing has finished, what method to call, and any context
    // third parameter needs to be a selector that lists the method on our view controller that will be called
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        
        if error == nil {
            
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos", preferredStyle:  .Alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            
            let ac = UIAlertController(title: "Saved Error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
        
    }
    
    
    
      // we need to call the applyprocessing method when the slider is dragged around
    @IBAction func intensityChanged(sender: AnyObject) {
        applyProcessing()
    }
    
    
}

