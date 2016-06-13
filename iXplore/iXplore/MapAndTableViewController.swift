//
//  MapAndTableViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import MapKit

class MapAndTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var tableView: UITableView!
    var places = [Place]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // get places
        self.places = Place.getPlaces()
        
        // set the table's data source and delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // set the type of the map
        self.mapView.mapType = MKMapType.Hybrid
        
        // register custom table cell
        self.tableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        // set the map's delegate to be self
        self.mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // return the number of rows in the given section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    // execute something once a cell in the table has been selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // deselect the other annotations
        for annotation in self.places {
//            self.mapView.deselectAnnotation(annotation, animated: true)
            self.mapView.removeAnnotation(annotation)
        }
        
        // deselect the row in the table
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // navigate to the selected region in the map
        let place = self.places[indexPath.row]
        let coord = place.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // select the annotation
        self.mapView.addAnnotation(place)
//        self.mapView.selectAnnotation(place, animated: true)
    }
    
    // return the cell at the given row in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // first initialize the cell
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        // set up the place object and set its label
        let place = self.places[indexPath.row]
        cell.cellLabel.text = place.title
        
        // set up the image from the given URL
        let url = NSURL(string: place.imageURL!)
        let data = NSData(contentsOfURL: url!)
        cell.cellImage.image = UIImage(data: data!)
        
        // set the date of the object
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm aaa"
        cell.dateLabel.text = dateFormatter.stringFromDate(place.date)
        
        // then return the cell
        return cell
    }
    
    // return the height of the cell at a given row
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    // return whether the cell at a row can be edited
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // method to execute when deleting a table cell
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            // remove place from backend
            self.places.removeAtIndex(indexPath.row)
            // remove row from table
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    // return the view for a given annotation on the map
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.animatesDrop = true
        if (annotation as! Place).favorite {
            pin.pinTintColor = UIColor.purpleColor()
        } else {
            pin.pinTintColor = UIColor.redColor()
        }
        
        return pin
    }

}
