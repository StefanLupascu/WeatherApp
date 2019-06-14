//
//  VenueManager.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 23/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

struct VenueManager {
    // MARK: - Properties
    
    typealias VenueDataCompletion = (Data?, ManagerError?) -> Void
    
    var baseURL: String {
        return "https://api.foursquare.com/v2/venues/explore"
    }
    
    var clientId: String {
        return "HPV02L0WU15LMS0DJGQMQQQVJPQ1JC3FAU55WFYKHK1KWLGR"
    }
    
    var clientSecret: String {
        return "EY2BFE10ODICFM4MTN443Z3NPR0RU5EUIHWHIVHRG4RCBG5U"
    }
    
    var date: String {
        return "20190101"
    }
    
    // MARK: - Functions
    
    func getVenues(city: City, completion: @escaping VenueDataCompletion) {
        let url = URL(string: "https://api.foursquare.com/v2/venues/explore?ll=\(city.latitude),\(city.longitude)&sortByDistance=1&limit=10&client_id=\(clientId)&client_secret=\(clientSecret)&v=\(date)")!
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        process(request: request, completion: completion)
    }
    
    // MARK: - Private Functions
    
    private func process(request: NSMutableURLRequest, completion: @escaping VenueDataCompletion) {
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else {
                print("failed request")
                completion(nil, .failedRequest)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("unknown")
                completion(nil, .unknown)
                return
            }

            guard response.statusCode == 200 else {
                print("failed request")
                completion(nil, .failedRequest)
                return
            }
            
            completion(data, nil)
            
        }.resume()
    }
}
