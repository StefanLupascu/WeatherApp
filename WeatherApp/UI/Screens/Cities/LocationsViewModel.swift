//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 01/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import CoreData

protocol LocationsDelegate: class {
    func didAddCity(ok: Bool)
}

final class LocationsViewModel {
    // MARK: - Properties
    
    var cities = [City]()
    var delegate: LocationsDelegate?
    
    private let cityManager = CityManager()
    
    // MARK: - Init
    
    init() {
        cities = getCities()
    }
    
    // MARK: - Functions
    
    func addCity(_ city: City) {
        let shouldAdd = !findCity(city: city)
        
        guard shouldAdd else {
            self.delegate?.didAddCity(ok: false)
            return
        }
        cities.append(city)
        PersistenceService.saveContext()
        self.delegate?.didAddCity(ok: true)
    }
    
    func removeCity(at index: Int) {
        PersistenceService.context.delete(cities[index])
        cities.remove(at: index)
        PersistenceService.saveContext()
    }
    
    func updateCity(city: City) {
        for index in 0 ..< cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
            }
        }
        PersistenceService.saveContext()
    }
    
    // MARK: - Private functions
    
    // Getting the city data from the local database
    private func getCities() -> [City] {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let cities = try PersistenceService.context.fetch(fetchRequest)
            return cities
        } catch {
            print("Error \(error)")
        }
        
        return []
    }
    
    private func findCity(city: City) -> Bool {
        for index in 0 ..< cities.count {
            if cities[index].name == city.name {
                return true
            }
        }
        
        return false
    }
}
