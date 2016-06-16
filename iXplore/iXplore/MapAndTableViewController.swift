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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        // TABLE WORK
        // set the table's data source and delegate
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // register custom table cell
        self.tableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        
        // MAP WORK
        // set the type of the map
        self.mapView.mapType = MKMapType.Hybrid
        // set the map's delegate to be self
        self.mapView.delegate = self
        
        // APP NAVIGATION WORK
        self.navigationController?.navigationBar.hidden = false
        let button = UIBarButtonItem(title: "New Place", style: UIBarButtonItemStyle.Plain, target: self,
                                     action: #selector(MapAndTableViewController.newPlaceButtonTapped))
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    // return the number of rows in the given section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaceController.sharedInstance.places.count
    }
    
    // execute something once a cell in the table has been selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // deselect the other annotations
        for annotation in PlaceController.sharedInstance.places {
            self.mapView.removeAnnotation(annotation)
        }
        
        // deselect the row in the table
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // navigate to the selected region in the map
        let place = PlaceController.sharedInstance.places[indexPath.row]
        let coord = place.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coord, span: span)
        self.mapView.setRegion(region, animated: true)
        
        // select the annotation
        self.mapView.addAnnotation(place)
    }
    
    // return the cell at the given row in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // first initialize the cell
        let cell = self.tableView.dequeueReusableCellWithIdentifier("CustomTableViewCell", forIndexPath: indexPath) as! CustomTableViewCell
        
        // set up the place object and set its label
        let place = PlaceController.sharedInstance.places[indexPath.row]
        cell.cellLabel.text = place.title
        
        // set up the image from the given URL
        cell.cellImage.image = Helper.getImageFromUrl(place.imageURL)
        
        // set the date of the object
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm aaa"
        cell.dateLabel.text = dateFormatter.stringFromDate(place.date)
        
        // update favorite for the cell
        if place.favorite {
            cell.starImage.image = UIImage(named: "star_pink.png")
        } else {
            cell.starImage.image = UIImage(named: "star_black.png")
        }
        
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
    
    func editRowAtIndexPath(action: UITableViewRowAction, indexPath: NSIndexPath) {
        let place = PlaceController.sharedInstance.places[indexPath.row]
        switch action.title! {
        case "Delete":
            // remove annotation from map
            self.mapView.removeAnnotation(place)
            // remove place from backend
            PlaceController.sharedInstance.removePlace(indexPath)
            // remove row from table
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case "Favorite", "Unfavorite":
            // set favorite property of the given place to true
            place.favorite = !place.favorite
            // remove and replace pin if the place is currently annotated
            if self.mapView.annotations.contains({item in
                return place.coordinate.latitude == item.coordinate.latitude && place.coordinate.longitude == item.coordinate.longitude
            }) {
                self.mapView.removeAnnotation(place)
                self.mapView.addAnnotation(place)
            }
            // update the cell in the table
            if place.favorite {
                (self.tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell).starImage.image = UIImage(named: "star_pink.png")
            } else {
                (self.tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell).starImage.image = UIImage(named: "star_black.png")
            }
            // now persist this change
            PlaceController.sharedInstance.updatePlace(place)
        default:
            break
        }
        
        self.tableView.setEditing(false, animated: true)
    }
    
    
    // return the possible actions at the given table row
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        // create delete button
        let delete = UITableViewRowAction(style: .Normal, title: "Delete", handler: {(action, path) in
            self.editRowAtIndexPath(action, indexPath: path)
        })
        delete.backgroundColor = UIColor.redColor()
        
        // create favorite button
        var favoriteMessage = "Favorite"
        if PlaceController.sharedInstance.places[indexPath.row].favorite {
            favoriteMessage = "Unfavorite"
        }
        let favorite = UITableViewRowAction(style: .Normal, title: favoriteMessage, handler: {(action, path) in
            self.editRowAtIndexPath(action, indexPath: path)
        })
        if PlaceController.sharedInstance.places[indexPath.row].favorite {
            favorite.backgroundColor = UIColor.orangeColor()
        } else {
            favorite.backgroundColor = UIColor.greenColor()
        }
        
        return [favorite, delete]
        
    }
    
    func newPlaceButtonTapped() {
        let npvc = NewPlaceViewController(nibName: "NewPlaceViewController", bundle: nil)
        self.presentViewController(npvc, animated: true, completion: nil)
    }
    
}
