//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Jenifer  on 6/15/16.
//  Copyright © 2016 Jenifer . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var temperature: Double = 0 {
        didSet{
            temperatureLabel.text = "\(temperature)°"
        }
    }
    
    var summary:String = "" {
        
        didSet{
            descriptionLabel.text = "\(summary)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Get the weather data from Weather Service
        Webservice.fetchWeatherData { (weather) -> Void in
            
            if let weather = weather {
                //Get the main thread to update the UI
                dispatch_async(dispatch_get_main_queue()) {
                    guard let temp = weather.temperature,
                        
                        let summ = weather.summary
                        else {
                            return
                    }
                    
                   self.temperature = temp
                    self.summary = summ
                    
                    }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

