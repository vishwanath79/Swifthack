//
//  ViewController.swift
//  10NamestoFaces
//
//  Created by Subramanian, Vishwanath on 7/11/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewPerson))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) ->
        Int {
            
            return 10
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCell
        
        return cell
        
    }
    
    func addNewPerson() {
    
    let picker = UIImagePickerController()
        
    picker.allowsEditing = true
    
    picker.delegate = self
        
    presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController (picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UiImage {
            
            newImage = possibleImage
        }  else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            newImage = possibleImage
        } else {
            
            return
        }
        
        let imageName = NSUUID().UUIDString
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)
        
        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            jpegData.writeToFile(imagePath, atomically: true)
            
        }

        dismissViewControllerAnimated(true, completion: nil)
        
        }
    
    func getDocumentsDirectory() -> NSString {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let documentsDirectory = paths[0]
        return documentsDirectory
        
    }
        
    }

}

