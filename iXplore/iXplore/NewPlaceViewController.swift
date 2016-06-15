//
//  NewPlaceViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-14.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import MapKit

class NewPlaceViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var latitudeField: UITextField!
    @IBOutlet var longitudeField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.longitudeField.delegate = self
        self.latitudeField.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
//        (self.parentViewController as? MapAndTableViewController)!.updatePlaces()
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // for now, assume all fields are filled properly
    @IBAction func addPlaceButtonTapped(sender: UIButton) {
        let coordinate = CLLocationCoordinate2D(latitude: Double(self.latitudeField.text!)!,
                                                longitude: Double(self.longitudeField.text!)!)
        PlaceController.sharedInstance.addPlace(coordinate, title: self.titleField.text!,
                                                placeDescription: self.descriptionField.text!)
        self.cancelButtonTapped(sender)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let allowedChars = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ""]
        if allowedChars.contains(string) {
            return true
        } else {
            return false
        }
        
    }
    
}
