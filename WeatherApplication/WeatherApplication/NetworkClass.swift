//
//  NetworkClass.swift
//  WeatherApplication
//
//  Created by Jenifer  on 6/15/16.
//  Copyright © 2016 Jenifer . All rights reserved.
//

import Foundation
import UIKit
/*
 Network Operator class downloads the data from a given URL and returns the JSON.
 */

struct NetworkOperator {
    
    let fetchURL: NSURL?
    
    //Custom Init to accept the URL
    init(url: NSURL) {
        fetchURL = url
    }
    
    //Downloads the data
    //Returns the JSON Dictionary
    func getWeatherData(completion: [String:AnyObject] -> Void) {
        
        //Create configuration object
        let configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //Create session object with configuration
        let session: NSURLSession = NSURLSession(configuration:configuration)
        
        //Create request object with URL
        let request = NSURLRequest(URL: fetchURL!)
        
        //Create data task
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            do{
                //Get json from Foundation Object
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String:AnyObject]
                completion(jsonDict)
            }
            catch {
                print("json error: \(error)")
            }
        });
        task.resume()
    }
}
