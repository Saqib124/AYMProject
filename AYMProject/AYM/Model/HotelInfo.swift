//
//  HotelInfo.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

enum hotel: String{
    case
    name = "hotelName",
    image  = "hotelImage",
    loaction = "hotelLoaction",
    type = "hotelType",
    noOfView = "noOfView",
    rating = "rating"
}


class HotelInfo: NSObject {
    var imageUrl : String
    var name : String
    var location: String
    var type: String
    var noOfView: Int
    var rating: Int
    
    init(attribute: Dictionary<String, Any>){
        self.imageUrl = attribute[hotel.image.rawValue] as! String
        self.name = attribute[hotel.name.rawValue] as! String
        self.location = attribute[hotel.loaction.rawValue] as! String
        self.type = attribute[hotel.type.rawValue] as! String
        self.noOfView = attribute[hotel.noOfView.rawValue] as! Int
        self.rating = attribute[hotel.rating.rawValue] as! Int
    }
}
