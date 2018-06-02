//
//  MainViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController {

    // MARK: - class objects
    let locationMgr = CLLocationManager()
    var userLocation:CLLocationCoordinate2D?
    var status: CLAuthorizationStatus = .notDetermined
    
    
    //    MARK: - controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main Menu"
        
        startLocationServices()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "RestSegue"{
            print("RestSegue")
            let destinationVC = segue.destination as! HotelListTableViewController
            destinationVC.userLocation = userLocation
        }
        else if segue.identifier == "WeatherSegue" {
            print("WeatherSegue")
            let destinationVC = segue.destination as! WeatherViewController
            destinationVC.userLocation = userLocation
        }
    }
    
    
    //    MARK: - button actions
    @IBAction func hotelInfoButtonClicked(_ sender: UIButton) {
        self.performeSegueNavigation(withIdentifier:"RestSegue" , self)
    }
    
    @IBAction func weatherInfoButtonClicked(_ sender: Any) {
        self.performeSegueNavigation(withIdentifier:"WeatherSegue" , self)
    }
    
    func performeSegueNavigation(withIdentifier identifier: String, _ sender: Any){
        guard let _:CLLocationCoordinate2D = userLocation else{
            let alert = UIAlertController(title: "Unable to get user location", message: "Please refresh the screen", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        self .performSegue(withIdentifier:identifier , sender: self)
    }
    
    @objc func addTapped() {
        startLocationServices()
    }
    

}



extension MainViewController: CLLocationManagerDelegate {
    
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

