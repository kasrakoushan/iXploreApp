//
//  AppDelegate.swift
//  iXplore
//
//  Created by Kasra Koushan on 2016-06-08.
//  Copyright © 2016 Kasra Koushan. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var mapAndTableNavigationController: UINavigationController?
    var authenticationNavigationController: UINavigationController?
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let loggedIn = false
        
        // set up map and table view controller
        let mapAndTableViewController = MapAndTableViewController(nibName: "MapAndTableViewController", bundle: nil)
        self.mapAndTableNavigationController = UINavigationController(rootViewController: mapAndTableViewController)
        
        // set up authentication view controller
        let avc = AuthenticationViewController(nibName: "AuthenticationViewController", bundle: nil)
        self.authenticationNavigationController = UINavigationController(rootViewController: avc)
        
        // go to the proper navigation controller
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if (loggedIn) {
            self.window?.rootViewController = self.mapAndTableNavigationController
        } else {
            self.window?.rootViewController = self.authenticationNavigationController
            
        }
        
        self.window?.makeKeyAndVisible()
        
        // prompt the user for location permissions
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func navigateToMainController() {
        self.window?.rootViewController = self.mapAndTableNavigationController
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        self.currentLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location manager had a failure.")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyKilometer
            self.locationManager?.startUpdatingLocation()
        }
    }
    

}

