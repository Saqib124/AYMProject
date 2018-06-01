//
//  MainViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation
class MainViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - class objects
    let locationMgr = CLLocationManager()
    var userLocation:CLLocationCoordinate2D?
    var status: CLAuthorizationStatus = .notDetermined
    
    
    //    MARK: - controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        startLocationServices()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
    }
    
    
    //    MARK: - button actions
    @IBAction func hotelInfoButtonClicked(_ sender: UIButton) {
        guard let _:CLLocationCoordinate2D = userLocation else{
            let alert = UIAlertController(title: "Unable to get user location", message: "Please refresh the screen", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        self .performSegue(withIdentifier: "RestSegue", sender: self)
    }
    
    @IBAction func weatherInfoButtonClicked(_ sender: Any) {
        guard let _:CLLocationCoordinate2D = userLocation else{
            let alert = UIAlertController(title: "Unable to get user location", message: "Please refresh the screen", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        self .performSegue(withIdentifier: "WeatherSegue", sender: self)
    }
    
    @objc func addTapped() {
        startLocationServices()
    }
    

}
