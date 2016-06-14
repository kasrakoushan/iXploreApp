//
//  PersistenceManager.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-14.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation
import MapKit

class PersistenceManager {
    
    static let PLACE_FILE_EXTENSION = "place"
    
    // store the given place at the current subdirectory of documents (default in documents/)
    class func storePlace(place: Place) {
        let file = PersistenceManager.documentsDirectory().stringByAppendingString("/\(place.coordinate.latitude),\(place.coordinate.longitude).\(PLACE_FILE_EXTENSION)")
        NSKeyedArchiver.archiveRootObject(place, toFile: file)
    }
    
    // obtain the place object with the given name or coordinates (ONE must be non-nil, otherwise will crash)
    class func loadPlace(name: String? = nil, location: CLLocationCoordinate2D? = nil) -> Place? {
        var file: String
        if name != nil {
            file = PersistenceManager.documentsDirectory().stringByAppendingString("/\(name!)")
        } else {
            file = PersistenceManager.documentsDirectory().stringByAppendingString("/\(location!.latitude),\(location!.longitude).\(PLACE_FILE_EXTENSION)")
        }
        return NSKeyedUnarchiver.unarchiveObjectWithFile(file) as? Place
        
    }
    
    // return the user's documents directory
    class func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentDirectory = paths[0]
        return documentDirectory
    }
}