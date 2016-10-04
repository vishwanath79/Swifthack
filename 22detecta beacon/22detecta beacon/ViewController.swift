//
//  ViewController.swift
//  22detecta beacon
//
//  Created by Subramanian, Vishwanath on 9/29/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!

    @IBOutlet var distanceReading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        view.backgroundColor = UIColor.gray
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager (_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
                
            }
        }
    }
    
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major:123, minor:456, identifier: "MyBeacon")
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func update(distance: CLProximity) {
        
        UIView.animate(withDuration: 0.8) { [unowned self] in
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNKNOWN"
                
            case .far:
                self.view.backgroundColor = UIColor.blue
                self.distanceReading.text = "FAR"
                
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "FAR"

            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
                
            }
    }

}

    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region:CLBeaconRegion) {
        
        if beacons.count > 0 {
            let beacon = beacons[0]
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
        
    }
    

}

