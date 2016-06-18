//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Subramanian, Vishwanath on 6/14/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    
    @IBOutlet var detailImageView: UIImageView!


    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(shareTapped))
        
        
        
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    func shareTapped() {
        
        //let vc = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
        //vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        //presentViewController(vc, animated: true, completion: nil)
        
        let vc1 = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        vc1.setInitialText("look at this great picture")
        vc1.addImage(detailImageView.image!)
        vc1.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl"))
        presentViewController(vc1, animated: true, completion: nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

}

