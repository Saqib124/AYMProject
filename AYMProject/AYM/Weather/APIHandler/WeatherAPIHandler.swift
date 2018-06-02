//
//  WeatherAPIHandler.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

protocol WeatherHandlerDelegate:class {
    func getTheWeather(array: Array<WeatherInfo>)
    func errorInFetchingWeather(error: Error)
}

class WeatherAPIHandler: NSObject {
    var weatherArray: [WeatherInfo] = []
    typealias JSONDictionary = [String: AnyObject]
    weak var delegate: WeatherHandlerDelegate?
    
    func getResultsFromAPI(location: CLLocationCoordinate2D) {
        let urlString = "https://weather.cit.api.here.com/weather/1.0/report.json?product=observation&latitude=\(location.latitude)&longitude=\(location.latitude)&oneobservation=true&app_id=ul3UuB6xEdZy46MZveNG&app_code=ffgyOzrdhBC7qlTpaq0uYQ"
        AlamofireHelper.requestGETURL(urlString, success: {
            (JSONResponse) -> Void in
            do{
                let Response = try self.readResponseFromTxt()
                try self.updateAPIResults(Response)
                self.delegate?.getTheWeather(array: self.weatherArray)
                
            }catch let error{
                self.delegate?.errorInFetchingWeather(error: error)
            }
        })
        {
            (error) -> Void in
            self.delegate?.errorInFetchingWeather(error: error)
        }
    }
    
    
    fileprivate func updateAPIResults(_ data: JSON) throws {
        let rawData = data.dictionary!["list"]
        let city = data.dictionary!["city"]!["name"]
        weatherArray.removeAll()
        if rawData == JSON.null {
            throw ParseError.emptyResponseError(message: "Dictionary does not contain results key")
        }
        var date = Date()
        let formatter = DateFormatter()
        var index = 0
        for weatherDictionary in (rawData?.array!)! {
            if weatherDictionary != JSON.null{
                var attribute = [String: Any]();
                formatter.dateFormat = (index == 0) ? "EEEE" : "EEE"
                attribute[Weather.city.rawValue] = city.string
                attribute[Weather.day.rawValue] = formatter.string(from: date)
                attribute[Weather.condition.rawValue] = (weatherDictionary["weather"][0]["description"].string)!
                attribute[Weather.temperature.rawValue] = String(format: "%.1f", (weatherDictionary["main"]["temp"].floatValue - 273.15))
                attribute[Weather.temperatureUnit.rawValue] = Unit.celsius
                attribute[Weather.windRate.rawValue] = String(format: "%.1f", weatherDictionary["wind"]["speed"].floatValue)
                attribute[Weather.humidity.rawValue] = String(format: "%.1f", weatherDictionary["main"]["humidity"].floatValue)
                attribute[Weather.weatherImage.rawValue] = (weatherDictionary["weather"][0]["main"].string)!
                weatherArray.append(WeatherInfo(attribute: attribute))
            }else {
                throw ParseError.parsingError(message: "Problem in parsing weather dictionary")
            }
            index = index + 1
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
            
        }
    }
    
    fileprivate func readResponseFromTxt() throws -> (JSON) {
        var json: JSON?
        if let filepath = Bundle.main.path(forResource: "weatherJSON", ofType: "txt") {
            do {
                let contents = try String(contentsOfFile: filepath)
                json = JSON.init(parseJSON:contents)
            } catch {
                throw ParseError.parsingError(message: "Problem in parsing weather dictionary")
            }
        } else {
            throw ParseError.emptyResponseError(message: "Dictionary does not contain results key")
        }
        return json!
    }

}
