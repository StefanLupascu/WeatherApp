//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import CoreData

protocol CitiesDelegate: class {
    func cityListChanged()
    func didNotAdd()
}

final class CityViewModel {
    // MARK: - Properties
    
    var cities = [City]()
    var delegate: CitiesDelegate?
    
    private let cityManager = CityManager()
    
    // MARK: - Init
    
    init() {
        guard Reachability.isConnectedToNetwork() else {
            getData()
            return
        }
        
        cityManager.fetchCities { (data, error) in
            guard let data = data else {
                return
            }
            self.format(data: data)
            DispatchQueue.main.async {
                self.delegate?.cityListChanged()
            }
        }
    }
    
    // MARK: - Functions
    
    func addCity(_ city: City) {
        let shouldAdd = !findCity(city: city)
        
        if Reachability.isConnectedToNetwork() {
            cityManager.saveCity(city: city)
        }
        
        guard shouldAdd else {
            self.delegate?.didNotAdd()
            return
        }
        cities.append(city)
        PersistenceService.saveContext()
    }
    
    func removeCity(at index: Int) {
        let city = cities[index]
        
        if Reachability.isConnectedToNetwork() {
            cityManager.deleteCity(city: city)
        }
        
        PersistenceService.context.delete(cities[index])
        cities.remove(at: index)
        PersistenceService.saveContext()
    }
    
    func updateCity(city: City) {
        if Reachability.isConnectedToNetwork() {
            cityManager.updateCity(city: city)
        }
        
        for index in 0 ..< cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
            }
        }
        PersistenceService.saveContext()
    }
    
    // MARK: - Private functions
    
    private func findCity(city: City) -> Bool {
        for index in 0 ..< cities.count {
            if cities[index].name == city.name {
                return true
            }
        }
        
        return false
    }
    
    private func getData() {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let cities = try PersistenceService.context.fetch(fetchRequest)
            self.cities = cities
        } catch {
            print("Error \(error)")
        }
    }
    
    private func format(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
            print("invalid response json")
            return
        }
        
        guard let cityData = json?["cityData"] as? [[String: AnyObject]] else {
            print("invalid response cityData")
            return
        }
        
        cityData.forEach { city in
            guard let name = city["name"] as? String,
                let latitude = Double((city["latitude"] as? String)!),
                let longitude = Double((city["longitude"] as? String)!),
                let note = city["notes"] as? String else {
                    print("invalid response")
                    return
            }
        
            let city = City(name: name, latitude: latitude, longitude: longitude, note: note)
            
            cities.append(city)
        }
    }
}
