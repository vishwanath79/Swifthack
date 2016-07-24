//
//  File.swift
//  10NamestoFaces
//
//  Created by Subramanian, Vishwanath on 7/24/16.
//  Copyright © 2016 Vish. All rights reserved.
//

import Foundation

//let defaults = NSUserDefaults.standardUserDefaults()

let defaults = NSUserDefaults.standardUserDefaults()

//WRITING DATA

//defaults.setInteger(25, forKey: "Age")
//defaults.setBool(true, forKey: "UserTouchID")
//defaults.setDouble(M_PI, forKey: "Pi")

// Using setObject() is just the same as using the other data types
//defaults.setObject("Paul Hudson", forKey: "Name")
//defaults.setObject(NSDate(), forKey: "LastRun")

let array = ["Hello", "World"]
//defaults.setObject(array, forKey: "SavedArray")


let dict = ["Name":"Paul", "Country":"UK"]
//defaults.setObject(dict, forKey: "SavedDict")

//READING DATA

//integerForKey() returns an integer if the key existed or o if not.

//objectForKey causes you the most bother as you get an optional object back

//let array = defaults.objectForKey("SavedArray") as? [String] ?? [String] ()

//if savedArray exists and is a string array, it will be placed into the array constant. If its doesnt exist (or if it does exists and is not a string array), then array gets set to be a new string array

//To read the dictionary we saved earlier we'd use this

//let dict = defaults.objectForKey("savedDict") as? [String:String] ?? [String:String]()
