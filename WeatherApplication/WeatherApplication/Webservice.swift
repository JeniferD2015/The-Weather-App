//
//  Webservice.swift
//  WeatherApplication
//
//  Created by Jenifer  on 6/15/16.
//  Copyright © 2016 Jenifer . All rights reserved.
//

import Foundation
import UIKit

struct Webservice {
    
    private static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    private static let APIkey = "c2723d669392f533d11bae3b985740a9"
    private static let countryCode = "6942553"
   // private static let unitInCelcius = "metric"
    
    private static func constructURL() -> NSURL {
        let weatherURLComponent = NSURLComponents(string: baseURL)
        let queryItem1 = NSURLQueryItem(name: "id", value: countryCode)
        let queryItem2 = NSURLQueryItem(name: "appId", value: APIkey)
       // let queryItem3 = NSURLQueryItem(name: "units", value: unitInCelcius)
        
        weatherURLComponent?.queryItems = [queryItem1, queryItem2]
        
        return (weatherURLComponent?.URL)!
    }
    
    static func fetchWeatherData(completion: Weather? -> Void)  {
        let url = constructURL()
        let nwOperator = NetworkOperator.init(url: url)
        nwOperator.getWeatherData ({ (jsonObj) -> Void in
            let weather = parseData(jsonObj)
            completion(weather)
        })
    }
    
    static func parseData(jsonDict: [String:AnyObject]?) -> Weather? {
        var weather = Weather()
        
        if let dict = jsonDict?["main"]{
            
            weather.temperature = (dict["temp"] as? Double)!
        }
        
        if let arrayDict = jsonDict?["weather"] as? NSArray {
            for item in (arrayDict as?  [[String:AnyObject]])!{
                weather.summary = (item["description"] as? String)
            }
        }
        
        
        return weather

    }
    
}