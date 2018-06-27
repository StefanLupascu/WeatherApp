//
//  City.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

struct City {
    // MARK: - Properties
    
    var name: String
    var latitude: Double
    var longitude: Double
    var details: Detail?
    var note: String?
    
    // MARK: - Init
    
    init(name: String, latitude: Double, longitude: Double, details: Detail? = nil, note: String? = nil) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.details = details
        self.note = note
    }
}

// MARK: - Equatable

extension City: Equatable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
