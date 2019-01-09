//
//  DataManager.swift
//  WeatherApp
//
//  Created by Stefan on 26/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
}

struct DataManager {
    // MARK: - Properties
    
    typealias WeatherDataCompletion = (Detail?, DataManagerError?) -> Void
    
    private var baseURL: String {
        return "https://api.forecast.io/forecast/b575743a969d064f18d37a4249f3fd4f/"
    }
    
    // MARK: - Functions
    
    func weatherDetailsFor(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        let url = URL(string: "\(baseURL)\(latitude),\(longitude)")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error, completion: { (details, error) in
                DispatchQueue.main.async {
                    completion(details, error)
                }
            })
        }.resume()
    }
    
    // MARK: - Private Functions
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        guard error == nil else {
            completion(nil, .failedRequest)
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            completion(nil, .unknown)
            return
        }
        
        guard response.statusCode == 200 else {
            completion(nil, .failedRequest)
            return
        }
        
        process(data: data, completion: completion)
    }
    
    private func process(data: Data, completion: WeatherDataCompletion) {
        // One of the few "try"s in the application
        // try? - returns an optional that can be unwrapped if successful or catches the error by returning nil; however the error is discarded
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as?  [String: AnyObject] else {
            completion(nil, .invalidResponse)
            return
        }
        
        guard let currently = json?["currently"] as? [String: AnyObject],
            let temperature = currently["temperature"] as? Double,
            let humidity = currently["humidity"] as? Double,
            let pressure = currently["pressure"] as? Double else {
                completion(nil, .invalidResponse)
                return
        }
        
        guard let hourly = json?["hourly"] as? [String: AnyObject],
            let summary = hourly["summary"] as? String else {
                completion(nil, .invalidResponse)
                return
        }
        
        let details = Detail(context: PersistenceService.context)
        details.temperature = temperature
        details.humidity = humidity
        details.pressure = pressure
        details.summary = summary
        completion(details, nil)
    }
}
