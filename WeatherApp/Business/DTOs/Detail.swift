//
//  Detail.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 30/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

struct Detail {
    // MARK: - Properties
    
    public var temperature: Double
    public var humidity: Double
    public var pressure: Double
    public var summary: String?
    
    init?(json: [String: Any]) {
        guard let currently = json["currently"] as? [String: AnyObject],
            let temperature = currently["temperature"] as? Double,
            let humidity = currently["humidity"] as? Double,
            let pressure = currently["pressure"] as? Double else {
                return nil
        }
        
        guard let hourly = json["hourly"] as? [String: AnyObject],
            let summary = hourly["summary"] as? String else {
                return nil
        }
        
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.summary = summary
    }
}
