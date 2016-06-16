//
//  AlertHelper.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-16.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    // convenience function for returning an alert controller to present
    class func returnOneOptionAlert(title: String, description: String, optionTitle: String, actionHandler: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .Alert)
        let action = UIAlertAction(title: optionTitle, style: .Default, handler: actionHandler)
        alert.addAction(action)
        return alert
    }
    
    // return the UIImage at the given URL (if one exists)
    class func getImageFromUrl(urlString: String?) -> UIImage? {
        if let string = urlString {
            if let url = NSURL(string: string) {
                if let data = NSData(contentsOfURL: url) {
                    return UIImage(data: data)
                }
            }
        }
        
        return nil
    }
}