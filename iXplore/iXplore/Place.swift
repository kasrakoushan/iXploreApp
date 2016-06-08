//
//  Place.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    var title: String? = ""
    var imageURL: String? = ""
    var coordinate: CLLocationCoordinate2D
    
    init(coord: CLLocationCoordinate2D, name: String? = nil, imageURL: String? = nil) {
        // initialize with given coordinates (and potentially with name and image URL)
        self.coordinate = coord
        self.title = name
        self.imageURL = imageURL
        
    }
    
    class func getPlaces() -> [Place] {
        // set points
        let points = [CLLocationCoordinate2D(latitude: 43.7735999, longitude: -79.4038429),
                      CLLocationCoordinate2D(latitude: 45.5094657, longitude: -73.5781447),
                      CLLocationCoordinate2D(latitude: 43.6573945, longitude: -79.3977025)]
        
        // set place objects
        let list = [Place(coord: points[0], name: "212 Parkview"),
                    Place(coord: points[1], name: "3574 Hutchison"),
                    Place(coord: points[2], name: "216 Beverley")]
        return list
    }
}