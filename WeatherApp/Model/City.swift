//
//  City.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 30/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

struct City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name
    }
    
    // MARK: - Properties
    
    let id: String?
    let name: String
    let latitude: Double
    let longitude: Double
    var note: String
    var details: Detail?
    
    // MARK: - Init
    
    init(id: String? = nil, name: String, latitude: Double, longitude: Double, note: String) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.note = note
    }
}
