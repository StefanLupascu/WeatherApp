//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Stefan Lupascu on 09/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import XCTest
import CoreData
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    func testCrud() {
        let viewModel = LocationsViewModel()
        
        XCTAssertEqual(viewModel.cities.count, 4)
        
        let city = City(name: "Timisoara", latitude: 1234.1234, longitude: 1234.1234, note: "Notes about Timisoara")
        viewModel.addCity(city)
        
        XCTAssertEqual(viewModel.cities.count, 5)
        
        let viewModel2 = LocationsViewModel()
        XCTAssertEqual(viewModel2.cities.count, 5)
        
        viewModel.removeCity(at: viewModel.cities.count - 1)
        XCTAssertEqual(viewModel.cities.count, 4)
    }
    
}
