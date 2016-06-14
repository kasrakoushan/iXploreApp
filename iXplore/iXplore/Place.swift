//
//  Place.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation, NSCoding {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var imageURL: String?
    var placeDescription: String?
    var date: NSDate
    var favorite: Bool
    
    init(coord: CLLocationCoordinate2D, title: String, imageURL: String?, description: String? = nil, date: NSDate? = nil, favorite: Bool? = false) {
        // initialize with given coordinates (and potentially with name and image URL)
        self.coordinate = coord
        if date != nil {
            self.date = date!
        } else {
            self.date = NSDate()
        }
        self.title = title
        self.imageURL = imageURL
        self.placeDescription = description
        if favorite != nil {
            self.favorite = favorite!
        } else {
            self.favorite = false
        }
        
        
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        // save all the properties with the appropriate keys
        aCoder.encodeObject(self.coordinate.latitude, forKey: "latitude")
        aCoder.encodeObject(self.coordinate.longitude, forKey: "longitude")
        aCoder.encodeObject(self.title, forKey: "title")
        aCoder.encodeObject(self.imageURL, forKey: "imageURL")
        aCoder.encodeObject(self.description, forKey: "description")
        aCoder.encodeObject(self.date, forKey: "date")
        aCoder.encodeObject(self.favorite, forKey: "favorite")
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeObjectForKey("latitude") as! CLLocationDegrees
        let longitude = aDecoder.decodeObjectForKey("longitude") as! CLLocationDegrees
        let title = aDecoder.decodeObjectForKey("title") as! String
        let imageURL = aDecoder.decodeObjectForKey("imageURL") as? String
        let description = aDecoder.decodeObjectForKey("description") as? String
        let date = aDecoder.decodeObjectForKey("date") as? NSDate
        let favorite = aDecoder.decodeObjectForKey("favorite") as? Bool
        
        self.init(coord: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), title: title,
                  imageURL: imageURL, description: description, date: date, favorite: favorite)
    }
}