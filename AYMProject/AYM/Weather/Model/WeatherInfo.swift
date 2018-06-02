//
//  WeatherInfo.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

enum Unit{
    case fahrenheit
    case celsius
    case kelvin
}

enum Weather: String{
    case city = "cityName"
    case day = "WeekDay"
    case condition = "WeatherCondition"
    case temperature = "Temperature"
    case temperatureUnit = "Unit"
    case windRate = "windRate"
    case humidity = "Humidity"
    case precipitation = "precipitation"
    case weatherImage = "weatherPic"
}

struct WeatherInfo {
    let city: String
    let day: String
    let condition: String
    let temperature: String
    let temperatureUnit: Unit
    let windRate: String
    let humidity: String
    let weatherImage: String
    
    init(attribute: Dictionary<String, Any>){
        self.city = attribute[Weather.city.rawValue] as! String
        self.day = attribute[Weather.day.rawValue] as! String
        self.condition = attribute[Weather.condition.rawValue] as! String
        self.temperature = attribute[Weather.temperature.rawValue] as! String
        self.temperatureUnit = attribute[Weather.temperatureUnit.rawValue] as! Unit
        self.windRate = attribute[Weather.windRate.rawValue] as! String
        self.humidity = attribute[Weather.humidity.rawValue] as! String
        self.weatherImage = attribute[Weather.weatherImage.rawValue] as! String
        
        
    }

}
