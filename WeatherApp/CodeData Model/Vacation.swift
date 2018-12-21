//
//  Vacation.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

typealias Destination = (City, NSDate)

struct Vacation {
    // MARK: - Properties
    
    var destinations = [Destination]()
    
    private let name: String
    
    // MARK: - Init
    
    init(name: String, destinations: [Destination]) {
        self.name = name
        self.destinations = destinations
    }
}
