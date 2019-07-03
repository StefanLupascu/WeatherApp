//
//  InformationViewModel.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 03/07/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import Foundation

final class InformationViewModel {
    // MARK: - Properties
    
    var city: City
    
    // MARK: - Init
    
    init(city: City) {
        self.city = city
    }
}
