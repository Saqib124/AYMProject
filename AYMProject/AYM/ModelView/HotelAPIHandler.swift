//
//  HotelAPIHandler.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

protocol HotelHandlerDelegate:class {
    func getTheHotels(array: Array<HotelInfo>)
    func errorInFetchingHotel(error: Error)
}

class HotelAPIHandler: NSObject {
    var hotels: [HotelInfo] = []
    var errorMessage = ""
    typealias JSONDictionary = [String: AnyObject]
    weak var delegate: HotelHandlerDelegate?
    
    func getResultsFromAPI(location: CLLocationCoordinate2D) {
        
        print("Delegate-locations = \(location.latitude) \(location.longitude)")
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.latitude),\(location.longitude)&radius=1500&type=restaurant&keyword=cruise&key=AIzaSyBT2Vtd5JxulM7pLWjBCvC5X9215p4qXWc"
        
        AlamofireHelper.requestGETURL(urlString, success: {
            (JSONResponse) -> Void in
            self.updateAPIResults(JSONResponse)
            self.delegate?.getTheHotels(array: self.hotels)
            //            print(JSONResponse)
        }) {
            (error) -> Void in
            self.delegate?.errorInFetchingHotel(error: error)
            //            print(error)
        }
    }
    
    
    fileprivate func updateAPIResults(_ data: JSON) {
        let rawData = data.dictionary!["results"]
        
        hotels.removeAll()
        
        guard let array = rawData else {
            errorMessage += "Dictionary does not contain results key\n"
            return
        }
        var index = 0
        
        for hotelDictionary in array.array! {
            if hotelDictionary != JSON.null{
                var attribute = [String: Any]();
                let photo_reference = hotelDictionary["photos"][0]["photo_reference"]
                let max_height = hotelDictionary["photos"][0]["height"]
                let max_weight = hotelDictionary["photos"][0]["width"]
                
                let icon_url = "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(photo_reference)&sensor=false&maxheight=\(max_height)&maxwidth=\(max_weight)&key=AIzaSyBT2Vtd5JxulM7pLWjBCvC5X9215p4qXWc"
                
                
                attribute[hotel.image.rawValue]   = icon_url
                attribute[hotel.name.rawValue]   = hotelDictionary["name"].string
                attribute[hotel.loaction.rawValue]    = hotelDictionary["vicinity"].string
                attribute[hotel.type.rawValue]   = (hotelDictionary["types"][0]).string
                attribute[hotel.noOfView.rawValue]   = 365
                attribute[hotel.rating.rawValue]   = (hotelDictionary["rating"] == JSON.null) ? 3 : hotelDictionary["rating"].intValue
                hotels.append(HotelInfo(attribute: attribute))
                index += 1
            }else {
                errorMessage += "Problem parsing trackDictionary\n"
            }
        }
    }
}
