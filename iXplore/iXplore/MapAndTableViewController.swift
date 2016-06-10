//
//  MapAndTableViewController.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import MapKit

class MapAndTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        self.tableView.registerNib(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // deselect the other annotations
        for annotation in self.places {
            self.mapView.deselectAnnotation(annotation, animated: true)
        }
        
        // un-highlight the row in the table
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // navigate to the selected region in the map
        let place = self.places[indexPath.row]
        let coord = place.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // select the annotation
        self.mapView.addAnnotation(place)
        self.mapView.selectAnnotation(place, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // first initialize the cell
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        // set up the image
        let place = self.places[indexPath.row]
        let url = NSURL(string: place.imageURL!)
        let data = NSData(contentsOfURL: url!)
        cell.cellLabel.text = self.places[indexPath.row].title
        cell.cellImage.image = UIImage(data: data!)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}
