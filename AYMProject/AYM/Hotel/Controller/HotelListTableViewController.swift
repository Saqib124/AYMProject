//
//  HotelListTableTableViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation

class HotelListTableViewController: UITableViewController {

    // MARK: - Class objects
    let tableCellIdentifier = "hotelCell"
    var hotelsArray: [HotelInfo] = []
    let hotelHandler = HotelAPIHandler()
    var userLocation:CLLocationCoordinate2D?
    
    var timer: Timer!
    var refreshBarButtonActivityIndicator: UIBarButtonItem!
    var refreshBarButton: UIBarButtonItem!
    
    @IBOutlet weak var tableview: UITableView!
    // MARK: - controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NearBy Restaurant"
        hotelHandler.delegate = self
        hotelHandler.getResultsFromAPI(location: userLocation!)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 64/255, green: 119/255, blue: 182/255, alpha: 1.0)
        self.tableView.allowsSelection = false;
        self.tableView.separatorColor = UIColor.clear
    }
    
    @objc func addTapped() {
        hotelHandler.getResultsFromAPI(location: userLocation!)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hotelsArray.count > 3 ? 3 : hotelsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! HotelInfoTableViewCell
        let hotel = self.hotelsArray[indexPath.row]
        cell.configure(hotel: hotel)
        return cell
    }
}

// MARK: Extension for hotel handler delegate
extension HotelListTableViewController: HotelHandlerDelegate  {
    
    func getTheHotels(array: Array<HotelInfo>){
        print("sucess")
        if array.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "Array count is zero", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.hotelsArray = array;
        self.tableView.reloadData()
    }
    
    func errorInFetchingHotel(error: Error){
        print("failure")
        let alert = UIAlertController(title: "Error Alert", message: "Error in fetching the records, please refresh the screen", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
