//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-14.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewPlaceViewController: UIViewController, UITextFieldDelegate {
    
    let ALLOWED_NUMERIC_CHARS = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ""]
    let REQUIRED_FIELDS = ["Latitude", "Longitude", "Title"]
    let NUMERIC_FIELDS = ["Latitude", "Longitude"]
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var latitudeField: UITextField!
    @IBOutlet var longitudeField: UITextField!
    @IBOutlet var addPlaceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the delegates of the text fields
        self.longitudeField.delegate = self
        self.latitudeField.delegate = self
        self.titleField.delegate = self
        self.descriptionField.delegate = self
        
        // turn off the add place button
        self.addPlaceButton.enabled = false
        self.addPlaceButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        self.addPlaceButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        // update the location once the view as appeared
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        app.locationManager?.requestLocation()
        if app.currentLocation != nil {
            self.latitudeField.text! = "\(app.currentLocation!.latitude)"
            self.longitudeField.text! = "\(app.currentLocation!.longitude)"
        } else {
            print("NewPlaceViewController.viewDidAppear: could not obtain location.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // for now, assume all fields are filled properly
    @IBAction func addPlaceButtonTapped(sender: UIButton) {
        let coordinate = CLLocationCoordinate2D(latitude: Double(self.latitudeField.text!)!,
                                                longitude: Double(self.longitudeField.text!)!)
        if (CLLocationCoordinate2DIsValid(coordinate)) {
            PlaceController.sharedInstance.addPlace(coordinate, title: self.titleField.text!,
                                                    placeDescription: self.descriptionField.text!)
            self.cancelButtonTapped(sender)
        } else {
            let alert = Helper.returnOneOptionAlert("Invalid Location",
                                                    description: "Please enter valid coordinates in order to save your place.",
                                                    optionTitle: "OK")
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    // manage text field
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // should eventually remove the force unwraps here
        let placeholder = textField.placeholder!
        let current = Array(textField.text!.characters)
        let latitude = Array(self.latitudeField.text!.characters)
        let longitude = Array(self.longitudeField.text!.characters)
        let title = Array(self.titleField.text!.characters)
        
        
        var secondLastCurrent: Character?
        var lastLongitude: Character?
        var lastLatitude: Character?
        if current.count > 1 {
            secondLastCurrent = current[current.count - 2]
        } else {
            secondLastCurrent = nil
        }
        if longitude.count > 0 {
            lastLongitude = longitude[longitude.count - 1]
        } else {
            lastLongitude = nil
        }
        if latitude.count > 0 {
            lastLatitude = latitude[latitude.count - 1]
        } else {
            lastLatitude = nil
        }
        
        var allow: Bool = true
        
        // check if the textField is numeric
        if self.NUMERIC_FIELDS.contains(placeholder) &&
            (!self.ALLOWED_NUMERIC_CHARS.contains(string) || // invalid character
                (textField.text?.characters.count > 0 && string == "-") || // '-' sign entered after first character
                (textField.text!.containsString(".") && string == ".") || // more than one '.' inserted
                (textField.text?.characters.count == 0 && string == ".")) { // '.' inserted before any number
            allow = false
        }
        
        // check if the textField is required
        if self.REQUIRED_FIELDS.contains(placeholder) {
            if (string == "" && current.count <= 1) || // current text field will be empty
                (latitude.count == 0 && (placeholder != "Latitude" || !allow)) || // latitude is empty and not changing
                (longitude.count == 0 && (placeholder != "Longitude" || !allow)) || // longitude is empty and not changing
                (title.count == 0 && placeholder != "Title") || // title is empty and not changing
                (self.NUMERIC_FIELDS.contains(placeholder) && (string == "." || string == "-") && allow) || // adding '.' or '-' to the end of a numeric field
                (self.NUMERIC_FIELDS.contains(placeholder) && string == "" && (secondLastCurrent == "." || secondLastCurrent == "-")) || // last char of numeric field becomes '-' or '.'
                ((lastLatitude == "." || lastLatitude == "-") && (placeholder != "Latitude" || !allow)) || // numeric field ends with '.' or '-'
                ((lastLongitude == "." || lastLongitude == "-") && (placeholder != "Longitude" || !allow)) {
                self.addPlaceButton.enabled = false
            } else {
                self.addPlaceButton.enabled = true
            }
        }
        
        return allow
        
    }
    
}
