//
//  WeatherViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherHandlerDelegate {

    
    // MARK: - Class variables
    let weatherHandler = WeatherAPIHandler()
    var weatherArray: [WeatherInfo] = []
    var userLocation:CLLocationCoordinate2D?
    
    // MARK: - controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather broadcast"
        weatherHandler.delegate = self
        weatherHandler.getResultsFromAPI(location: userLocation!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func addTapped() {
        weatherHandler.getResultsFromAPI(location: userLocation!)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
