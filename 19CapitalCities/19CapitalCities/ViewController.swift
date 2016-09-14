//
//  ViewController.swift
//  19CapitalCities
//
//  Created by Subramanian, Vishwanath on 9/13/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController , MKMapViewDelegate{

    @IBOutlet var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")

        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
  
    }

    
    func mapView(__ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // define a reuse identifier, string that will be used to ensure we reuse annotation views as much as possible
        
        let identifier = "Capital"
        
        // check whether annotation we're creating a view is one of our capital objects
        
        if annotation is Capital {
            
            // try to dequeue an annotation view from the map views pool of unused views
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
            
            if annotationView == nil {
                //if itsnt able to find a reusable view, create a new one using MKPinannotationview and sets its canshowcallout property to true. This triggers popup with city name
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                
                
            //create new UIBUtton using built in detaildisclosure type, this is a small blue "i" symbol with a circle around it
                let btn = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
                
                
            } else {
                
                //if it can reuse a view ,update the view to use a different annotation
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        //if annotation is not from a capital city return nil so ios used a default view
        return nil
    }
    
    
    func mapView (__ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAcessoryControlTapped control:UIControl) {
        
        let capital = view.annotation as! Capital
        let placeName = capital.title
        let placeInfo = capital.info
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default)
        present(ac, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

