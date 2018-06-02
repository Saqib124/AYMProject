//
//  HotelInfo.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

enum Hotel: String{
    case name = "hotelName"
    case image  = "hotelImage"
    case loaction = "hotelLoaction"
    case type = "hotelType"
    case noOfView = "noOfView"
    case rating = "rating"
}

struct HotelInfo {
    var imageUrl : String
    var name : String
    var location: String
    var type: String
    var noOfView: Int
    var rating: Int
    
    init(attribute: Dictionary<String, Any>){
        self.imageUrl = attribute[Hotel.image.rawValue] as! String
        self.name = attribute[Hotel.name.rawValue] as! String
        self.location = attribute[Hotel.loaction.rawValue] as! String
        self.type = attribute[Hotel.type.rawValue] as! String
        self.noOfView = attribute[Hotel.noOfView.rawValue] as! Int
        self.rating = attribute[Hotel.rating.rawValue] as! Int
    }
}
