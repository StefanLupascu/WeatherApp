//
//  City.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

final class City {
    
    var name: String
    var details: Detail
    
    init(name: String, details: Detail) {
        self.name = name
        self.details = details
    }
}
