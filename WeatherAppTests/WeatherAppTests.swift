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

    func testCity() {
        let city = City(name: "Cluj", latitude: 1234.1234, longitude: 1234.1234, note: "Notes about Cluj")
        
        XCTAssertEqual(city.name, "Cluj")
        XCTAssertEqual(city.latitude, city.longitude)
        XCTAssertEqual(city.note, "Notes about Cluj")
        
        XCTAssertNil(city.details)
    }
    
    func testVacation() {
        let city = City(name: "Timisoara", latitude: 1234.1234, longitude: 1234.1234, note: "Notes about Timisoara")
        let city2 = City(name: "Cluj", latitude: 1234.1234, longitude: 1234.1234, note: "Notes about Cluj")
        let date = NSDate()
        
        let destination = Destination(city, date)
        let destination2 = Destination(city2, date)
        
        let vacation = Vacation(name: "MyVacation", destinations: [destination, destination2])
        
        XCTAssertEqual(vacation.name, "MyVacation")
        XCTAssertEqual(vacation.destinations.count, 2)
    }

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
