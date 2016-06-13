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
    var title: String?
    var imageURL: String?
    var coordinate: CLLocationCoordinate2D
    var placeDescription: String?
    var date: NSDate
    var favorite: Bool
    
    init(coord: CLLocationCoordinate2D, title: String? = nil, imageURL: String? = nil, description: String? = nil) {
        // initialize with given coordinates (and potentially with name and image URL)
        self.coordinate = coord
        self.date = NSDate()
        self.title = title
        self.imageURL = imageURL
        self.placeDescription = description
        self.favorite = true
        
    }
    
    class func getPlaces() -> [Place] {
        // set points
        let points = [CLLocationCoordinate2D(latitude: 43.7735999, longitude: -79.4038429),
                      CLLocationCoordinate2D(latitude: 45.5094657, longitude: -73.5781447),
                      CLLocationCoordinate2D(latitude: 43.6573945, longitude: -79.3977025),
                      CLLocationCoordinate2D(latitude: -33.9077675, longitude: 18.4069913),
                      CLLocationCoordinate2D(latitude: 48.8589507, longitude: 2.2775172),
                      CLLocationCoordinate2D(latitude: 38.8976805, longitude: -77.0387185),
                      CLLocationCoordinate2D(latitude: 41.8902142, longitude: 12.4900422),
                      CLLocationCoordinate2D(latitude: 25.1968694, longitude: 55.2721607),
                      CLLocationCoordinate2D(latitude: 37.4038824, longitude: -122.1162865),
                      CLLocationCoordinate2D(latitude: 48.8048684, longitude: 2.1181667)]
        
        // set place objects
        let list = [Place(coord: points[0], title: "212 Parkview", imageURL: "https://geo2.ggpht.com/cbk?panoid=b4K3HjOAEoqL0ggvumZKEA&output=thumbnail&cb_client=search.TACTILE.gps&thumb=2&w=408&h=256&yaw=1.1468439&pitch=0"),
                    Place(coord: points[1], title: "3574 Hutchison", imageURL: "https://geo0.ggpht.com/cbk?panoid=NeNAUatVRoJKeBdrB_Wckw&output=thumbnail&cb_client=search.TACTILE.gps&thumb=2&w=408&h=256&yaw=207.83626&pitch=0"),
                    Place(coord: points[2], title: "216 Beverley", imageURL: "https://geo0.ggpht.com/cbk?panoid=aBFH7ttzI-XTrC5GSA26oA&output=thumbnail&cb_client=search.TACTILE.gps&thumb=2&w=408&h=256&yaw=252.88371&pitch=0"),
                    Place(coord: points[3], title: "never@home", imageURL: "https://lh4.googleusercontent.com/proxy/sElPUCxxdok5JanZ_WUMsN6eiv42hK4NEiXGWGLJuVfYNavJ_oTjaSzkE3p8noMXNHiJwEJmgEerHwulcz73vCu0lFTR0hASAyKNB2nqlDnNFAgDMYNBDsK-Nmg7WNrWrPTHJAecy5ECTuJGZHEQON_hIA=w408-h306"),
                    Place(coord: points[4], title: "Paris", imageURL: "https://lh4.googleusercontent.com/proxy/hVQUcbj-fu3GIfbgsT4P65r5N4oKB2qY0JkginJC9GMPyv_oD-R0HM9Er6VFV4zqJ5X7zmLfbJiGpiohbYuSGvGBp_g=w489-h256"),
                    Place(coord: points[5], title: "The White House", imageURL: "https://lh4.googleusercontent.com/proxy/x_61HpkAyfSd78gMhctVbeY_KGA3Ez9sgSKVHdcYV7Uaikv25OppNQWT7NsmIC2oCkIv0wEfvvizB_Y84RsK9KRv2BF4KxfDzCo7DmmSZfMRBfnjddCItjrEzZpZ1XmKwPfgTwURTShd7Kt7uxYB9kawOvsnkg=w491-h256"),
                    Place(coord: points[6], title: "The Coliseum", imageURL: "https://lh4.googleusercontent.com/-xaN8dZdkYhI/VxaxZS6hO1I/AAAAAAABYYU/86hElHoNHVMuD_toxNFnr67sH-JKsiQjw/s408-k-no/"),
                    Place(coord: points[7], title: "Burj Khalifa", imageURL: "https://lh6.googleusercontent.com/-JG8LCz86B2c/VyHfRgS-CKI/AAAAAAAADJw/SXgekJi2LjALrVlOab0DcwZWlaebgr3bACLIB/s725-k-no/"),
                    Place(coord: points[8], title: "Mountain View", imageURL: "https://lh4.googleusercontent.com/-A0dV-wJ_lKo/VJvtmwoHcwI/AAAAAAAAC0w/Lhk0NehIJZ0r3t9hTVcDcBTbwBm1Ak4_A/w512-h256-n-k-no/"),
                    Place(coord: points[9], title: "Palace of Versailles", imageURL: "https://lh6.googleusercontent.com/proxy/9hnSL0A7XeyxD9USH9sJvpO5DJnnwzbmC_cndib2-dG5Y-rliRtreoal-fyNW_ao98mThyZNkP13SL_I9U1XrR952EY7LUwETyArzYiI2_eLgoewd5FVWyJit-jSlJ_7FIVdUfoAHnsMDPA9UHEf2BIzYBRMSQI=w408-h408")]
        return list
    }
}