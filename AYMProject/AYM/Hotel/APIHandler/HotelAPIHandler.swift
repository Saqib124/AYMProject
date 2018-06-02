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

enum ParseError : Error {
    case parsingError(message: String)
    case emptyResponseError(message: String)
}

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
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location.latitude),\(location.longitude)&radius=1500&type=restaurant&keyword=cruise&key=AIzaSyBT2Vtd5JxulM7pLWjBCvC5X9215p4qXWc"
        AlamofireHelper.requestGETURL(urlString, success: {
            (JSONResponse) -> Void in
            do{
                try self.updateAPIResults(JSONResponse)
                self.delegate?.getTheHotels(array: self.hotels)
            }catch let error{
                self.delegate?.errorInFetchingHotel(error: error)
            }
            
        })
        {
            (error) -> Void in
            self.delegate?.errorInFetchingHotel(error: error)
        }
    }
    
    
    fileprivate func updateAPIResults(_ data: JSON) throws {
        let rawData = data.dictionary!["results"]
        hotels.removeAll()
        guard let array = rawData else {
            throw ParseError.emptyResponseError(message: "Dictionary does not contain results key")
        }
        for hotelDictionary in array.array! {
            if hotelDictionary != JSON.null{
                var attribute = [String: Any]();
                let photo_reference = hotelDictionary["photos"][0]["photo_reference"]
                let max_height = hotelDictionary["photos"][0]["height"]
                let max_weight = hotelDictionary["photos"][0]["width"]
                let icon_url = "https://maps.googleapis.com/maps/api/place/photo?photoreference=\(photo_reference)&sensor=false&maxheight=\(max_height)&maxwidth=\(max_weight)&key=AIzaSyBT2Vtd5JxulM7pLWjBCvC5X9215p4qXWc"
                attribute[Hotel.image.rawValue] = icon_url
                attribute[Hotel.name.rawValue] = hotelDictionary["name"].string
                attribute[Hotel.loaction.rawValue] = hotelDictionary["vicinity"].string
                attribute[Hotel.type.rawValue] = (hotelDictionary["types"][0]).string
                attribute[Hotel.noOfView.rawValue] = 365
                attribute[Hotel.rating.rawValue] = (hotelDictionary["rating"] == JSON.null) ? 3 : hotelDictionary["rating"].intValue
                hotels.append(HotelInfo(attribute: attribute))
            } else {
                throw ParseError.parsingError(message: "Problem in parsing hotel dictionary")
            }
        }
    }
}
