//
//  Detail.swift
//  WeatherApp
//
//  Created by Stefan on 27/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

struct Detail {
    
    var temperature: Double
    var humidity: Double
    var pressure: Double
    var precipitationProbability: Double
    var summary: String
    
    init() {
        temperature = 0.00
        humidity = 0.00
        pressure = 0.00
        precipitationProbability = 0.00
        summary = ""
    }
    
    init(temperature: Double, humidity: Double, pressure: Double, precipitationProbability: Double, summary: String) {
        
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.precipitationProbability = precipitationProbability
        self.summary = summary
    }
}
