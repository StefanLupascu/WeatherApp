//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 09/02/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation
import MapKit

struct LocationManager {
    // MARK: - Properties
    
    typealias CityNameCompletion = (String?, String?, DataManagerError?) -> Void
    
    // MARK: - Functions
    
    func getCityAt(latitude: Double, longitude: Double, completion: @escaping CityNameCompletion){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) in
            
            let placeArray = placemarks as [CLPlacemark]?
            
            guard let placeMark = placeArray?[0] else {
                completion(nil, nil, .unknown)
                return
            }
            
            guard let countryName = placeMark.country else {
                completion(nil, nil, .failedRequest)
                return
            }
            
            guard let locationName = placeMark.locality else {
                completion(nil, countryName, .unknown)
                return
            }
            
            DispatchQueue.main.async {
                completion(locationName, countryName, nil)
            }
        }
    }
}
