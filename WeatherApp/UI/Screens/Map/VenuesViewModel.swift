//
//  VenuesViewModel.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 23/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

protocol VenuesViewDelegate {
    func showVenues()
}

final class VenuesViewModel {
    // MARK: - Properties
    
    var delegate: VenuesViewDelegate?
    
    var venues = [Venue]()
    
    private let manager = VenueManager()
    
    // MARK: - Init
    
    init(city: City) {
        getVenues(city: city)
    }
    
    // MARK: - Private Functions
    
    private func getVenues(city: City) {
        manager.getVenues(city: city) { data, error in
            guard let data = data else {
                return
            }
            
            self.format(data: data)
            DispatchQueue.main.async {
                self.delegate?.showVenues()
            }
        }
    }
    
    private func format(data: Data) {
        guard let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]) as [String : AnyObject]??) else {
            print("invalid response")
            return
        }
    
        guard let response = json?["response"] as? [String: AnyObject],
                let groups = response["groups"] as? [[String: AnyObject]],
                let items = groups[0]["items"] as? [[String: AnyObject]] else {
            return
        }
        
        items.forEach { item in
            guard let venue = item["venue"] as? [String: AnyObject],
                    let name = venue["name"] as? String,
                    let location = venue["location"] as? [String: AnyObject],
                    let latitude = location["lat"] as? Double,
                    let longitude = location["lng"] as? Double else {
                return
            }

            let newVenue = Venue(name: name, latitude: latitude, longitude: longitude)

            venues.append(newVenue)
        }
    }
}
