//
//  Destination.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 20/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

struct Destination {
    // MARK: - Properties
    
    let city: City
    let date: String
    
    // MARK: - Init
    
    init(city: City, date: String) {
        self.city = city
        self.date = date
    }
}
