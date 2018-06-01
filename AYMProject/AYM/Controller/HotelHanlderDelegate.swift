//
//  HotelHanlderDelegate.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

extension HotelListTableViewController  {
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
