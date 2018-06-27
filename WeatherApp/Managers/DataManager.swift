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
    
    case unknown
    case failedRequest
    case invalidResponse
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
    func weatherData(for location: CLLocationCoordinate2D, completion: @escaping WeatherDataCompletion) {
        // Create URL
        let URL = baseURL.appendingPathComponent("\(location.latitude),\(location.longitude)")
        
        //Create Data Task
        URLSession.shared.dataTask(with: URL) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
    private func processWeatherData(data: Data, completion: WeatherDataCompletion) {
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            if let content = JSON as? [String: AnyObject] {
                self.content = content
            }
            completion(JSON, nil)
        } else {
            completion(nil, .invalidResponse)
        }
    }
    
    func addWeatherInfo() -> City{
        
        guard let timezone = content["timezone"] as? String,  let currently = content["currently"] as? [String: AnyObject], let temperature = currently["apparentTemperature"] as? Double  else { return City(name: "Default", temperature: 0.00, notes: "") }
        let weatherInfo = City(name: timezone, temperature: temperature, notes: "")
        
        return weatherInfo
    }
    
    
}
