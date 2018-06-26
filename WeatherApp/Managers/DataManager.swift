//
//  DataManager.swift
//  WeatherApp
//
//  Created by Stefan on 26/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation
import MapKit

enum DataManagerError: Error {
    
    case Unknown
    case FailedRequest
    case InvalidResponse
}

final class DataManager {
    
    typealias WeatherDataCompletion = (AnyObject?, DataManagerError?) -> ()
    
    let baseURL: URL
    var content = [String: AnyObject]()
    
    //Mark: - Initialization
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    //Mark: - Requesting Data
    
    //latitude: Double, longitude: Double
    func weatherDataForLocation(location: CLLocationCoordinate2D, completion: @escaping WeatherDataCompletion) {
        // Create URL
        let URL = baseURL.appendingPathComponent("\(location.latitude),\(location.longitude)")
        
        //Create Data Task
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, .FailedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }
        } else {
            completion(nil, .Unknown)
        }
    }
    
    private func processWeatherData(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            if let content = JSON as? [String: AnyObject] {
                self.content = content
            }
            completion(JSON, nil)
        } else {
            completion(nil, .InvalidResponse)
        }
    }
    
    func addWeatherInfo() -> City{
        
//        if let timezone = content["timezone"] as? String,
//        let currently = content["currently"] as? [String: AnyObject],
//            let temperature = currently["apparentTemperature"] as? Double {
//            let weatherInfo = City(name: timezone, temperature: temperature)
//
//            return weatherInfo
//        }
        guard let timezone = content["timezone"] as? String,  let currently = content["currently"] as? [String: AnyObject], let temperature = currently["apparentTemperature"] as? Double  else { return City(name: "Default", temperature: 0.00) }
        let weatherInfo = City(name: timezone, temperature: temperature)
        
        return weatherInfo
       // return City(name: "Default", temperature: 0.00)
    }
    
    
}
