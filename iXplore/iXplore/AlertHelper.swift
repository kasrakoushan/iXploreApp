//
//  AlertHelper.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-16.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper {
    
    // convenience function for returning an alert controller to present
    class func returnOneOptionAlert(title: String, description: String, optionTitle: String, actionHandler: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .Alert)
        let action = UIAlertAction(title: optionTitle, style: .Default, handler: actionHandler)
        alert.addAction(action)
        return alert
    }
}