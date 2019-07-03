//
//  DataManager.swift
//  WeatherApp
//
//  Created by Stefan on 26/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

struct DataManager {
    // MARK: - Properties
    
    typealias WeatherDataCompletion = (Detail?, ManagerError?) -> Void
    typealias TemperatureDataCompletion = (Data?, ManagerError?) -> Void
    
    private var baseURL: String {
        return "https://api.forecast.io/forecast/b575743a969d064f18d37a4249f3fd4f/"
    }
    
    // MARK: - Functions
    
    func weatherDetailsFor(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        let url = URL(string: "\(baseURL)\(latitude),\(longitude)")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error: error) { (details, error) in
                DispatchQueue.main.async {
                    completion(details, error)
                }
            }
        }.resume()
    }
    
    func getTemperature(for city: City, timestamp: TimeInterval, completion: @escaping TemperatureDataCompletion) {
        let date = Int(timestamp)
        
        let url = URL(string: "\(baseURL)\(city.latitude),\(city.longitude),\(date)")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            self.didFetchTemperature(data: data, response: response, error: error) { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            }
        }.resume()
    }
    
    // MARK: - Private Functions
    
    private func didFetchTemperature(data: Data?, response: URLResponse?, error: Error?, completion: @escaping TemperatureDataCompletion) {
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
        
        completion(data, nil)
    }
    
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: @escaping WeatherDataCompletion) {
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
        guard let response = try? JSONSerialization.jsonObject(with: data, options: []),
            let json = response as? [String: AnyObject] else {
            completion(nil, .invalidResponse)
            return
        }
        
        let details = Detail(json: json)
        
        completion(details, nil)
    }
}
