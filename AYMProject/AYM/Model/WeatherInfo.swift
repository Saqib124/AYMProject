//
//  WeatherInfo.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

enum unit{
    case fahrenheit
    case celsius
    case kelvin
}


enum weather: String{
    case
    city = "cityName",
    day  = "WeekDay",
    condition = "WeatherCondition",
    temperature = "Temperature",
    temperatureUnit = "Unit",
    windRate = "windRate",
    humidity = "Humidity",
    precipitation = "precipitation",
    weatherImage = "weatherPic"
}

class WeatherInfo: NSObject {
    let city: String
    let day: String
    let condition: String
    let temperature: String
    let temperatureUnit: unit
    let windRate: String
    let humidity: String
    let weatherImage: String
    
    init(attribute: Dictionary<String, Any>){
        self.city = attribute[weather.city.rawValue] as! String
        self.day = attribute[weather.day.rawValue] as! String
        self.condition = attribute[weather.condition.rawValue] as! String
        self.temperature = attribute[weather.temperature.rawValue] as! String
        self.temperatureUnit = attribute[weather.temperatureUnit.rawValue] as! unit
        self.windRate = attribute[weather.windRate.rawValue] as! String
        self.humidity = attribute[weather.humidity.rawValue] as! String
        self.weatherImage = attribute[weather.weatherImage.rawValue] as! String
        
        
    }

}
