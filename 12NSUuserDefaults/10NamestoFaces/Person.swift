//
//  Person.swift
//  10NamestoFaces
//
//  Created by Subramanian, Vishwanath on 7/14/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import UIKit

//You can save any kind of data inside NSUserDefaults
//You use the archivedDataWithRootObject() method of NSKeyedArchiver which turns an object graph into an NSData object and the nwrite it to NSUserDefaults as if it were anotehr object



class Person: NSObject, NSCoding {
    
    var name: String
    var image: String

    
    init(name: String, image: String) {
        
        self.name = name
        self.image = image
    }
    
 //You will need to write new class NSCoder that is responsible for both encoding(writing) and decoding(reading) your data so it can be used with NSUserDedaults
    
 // initializer must be declared with the required keyword - "if anyone tries to subclass this class, they are required to implement this method
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        image = aDecoder.decodeObjectForKey("image") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(image,forKey: "image")
    }
    
    //with above change sthe person class now confroms to NSCoding so we can go back to viewController.swift and add code to load and save the people array
    

    
}


