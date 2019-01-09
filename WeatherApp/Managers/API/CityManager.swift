//
//  CarManager.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

enum CityManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
}

final class CityManager {
    // MARK: - Properties
    
    typealias CityDataCompletion = (Data?, DataManagerError?) -> Void
    
    //192.168.0.102
    
    private let postURL = "http://172.30.115.198/CityAPI/api/addCity.php"
    private let getURL = "http://172.30.115.198/CityAPI/api/getCities.php"
    private let deleteURL = "http://172.30.115.198/CityAPI/api/deleteCity.php"
    private let updateURL = "http://172.30.115.198/CityAPI/api/updateCity.php"
    
//    private let postURL = "http://192.168.0.102/CityAPI/api/addCity.php"
//    private let getURL = "http://192.168.0.102/CityAPI/api/getCities.php"
//    private let deleteURL = "http://192.168.0.102/CityAPI/api/deleteCity.php"
//    private let updateURL = "http://192.168.0.102/CityAPI/api/updateCity.php"
    
    // MARK: - Functions
    
    //GET
    func fetchCities(completion: @escaping CityDataCompletion) {
        let url = URL(string: getURL)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.didFetchCities(data: data, response: response, error: error, completion: { (data, error) in
                DispatchQueue.main.async {
                    completion(data, error)
                }
            })
        }.resume()
    }
    
    //POST
    func saveCity(city: City) {
        let url = URL(string: postURL)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let name = city.name,
                let notes = city.note else {
                return
        }
        let latitude = city.latitude
        let longitude = city.longitude
        
        let postParameters = "name=\(name)&latitude=\(latitude)&longitude=\(longitude)&notes=\(notes)"
        request.httpBody = postParameters.data(using: .utf8)
        
        processRequest(request: request)
    }
    
    //UPDATE
    func updateCity(city: City) {
        let url = URL(string: updateURL)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let name = city.name,
                let note = city.note else {
            return
        }
        
        let updateParameters = "name=\(name)&notes=\(note)"
        request.httpBody = updateParameters.data(using: .utf8)
        
        processRequest(request: request)
    }
    
    //DELETE
    func deleteCity(city: City) {
        let url = URL(string: deleteURL)!
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        
        
        guard let name = city.name else {
            return
        }
        
        let deleteParameters = "name=\(name)"
        request.httpBody = deleteParameters.data(using: .utf8)
        
        processRequest(request: request)
    }
    
    // MARK: - Private functions
    
    private func didFetchCities(data: Data?, response: URLResponse?, error: Error?, completion: CityDataCompletion) {
        guard error == nil else {
            print("failed request")
            completion(nil, .failedRequest)
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse else {
            print("unkown error")
            completion(nil, .unknown)
            return
        }
        
        guard response.statusCode == 200 else {
            print("failed request from status code")
            completion(nil, .failedRequest)
            return
        }
        
        completion(data, nil)
    }
    
    private func processRequest(request: NSMutableURLRequest) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("failed request")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unkown")
                return
            }
            
            guard response.statusCode == 200 else {
                print("failed request")
                return
            }
            
            // May be one of the only try blocks in the app
            // Same as the one from DataManager
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                print("invalid response")
                return
            }
            
            guard let message = json?["message"] as? String else {
                print("invalid response from message")
                return
            }
            
            print(message)
            
        }.resume()
    }
}
