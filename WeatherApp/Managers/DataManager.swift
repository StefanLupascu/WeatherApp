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
    typealias TemperatureDataCompletion = (Data?, DataManagerError?) -> Void
    
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
    
    func getTemperature(for city: City, date: TimeInterval, completion: @escaping TemperatureDataCompletion) {
        let timestamp = Int(date)
        
        let url = URL(string: "\(baseURL)\(city.latitude),\(city.longitude),\(timestamp)")!
        
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
