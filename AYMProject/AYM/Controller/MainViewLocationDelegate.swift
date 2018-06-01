//
//  MainViewLocationDelegate.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation

extension MainViewController {
    
    //    MARK: - loaction setup
    func startLocationServices(){
        locationMgr.requestAlwaysAuthorization()
        status  = CLLocationManager.authorizationStatus()
        if status == .denied || status == .restricted {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        if CLLocationManager.locationServicesEnabled(){
            locationMgr.delegate = self
            locationMgr.startUpdatingLocation()
        }
    }
    
    
    //    MARK: - loaction delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            return
        }
        userLocation = locValue
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationMgr.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }

}
