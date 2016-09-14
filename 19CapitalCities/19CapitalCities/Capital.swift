//
//  Capital.swift
//  19CapitalCities
//
//  Created by Subramanian, Vishwanath on 9/13/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit
import MapKit

// MKAnnotation protocol is the one we need in order to create map annotations

class Capital: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    // with this custom subclass we can create capital cities passing in theri name coordinate and inforamtion
    
    init(title: String, coordinate: CLLocationCoordinate2D, info:String) {
        
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }

}

