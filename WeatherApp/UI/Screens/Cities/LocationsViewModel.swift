//
//  LocationsViewModel.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 01/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import CoreData
import Firebase

protocol LocationsDelegate: class {
    func didAddCity(ok: Bool)
    func didFetchCities()
}

final class LocationsViewModel {
    // MARK: - Properties
    
    var cities = [City]()
    var delegate: LocationsDelegate?
    
    private var uid: String {
        guard let user = Auth.auth().currentUser else {
            fatalError("No user logged in!")
        }
        
        return user.uid
    }
    private let cityManager = CityManager()
    private var ref: DatabaseReference {
        return Database.database().reference()
    }
    
    // MARK: - Init
    
    init() {
        getLocations()
    }
    
    // MARK: - Functions
    
    func addCity(_ city: City) {
        let shouldAdd = !findCity(city: city)
        
        guard shouldAdd else {
            self.delegate?.didAddCity(ok: false)
            return
        }
        
        cities.append(city)
        addToDatabase(city)
        
        self.delegate?.didAddCity(ok: true)
    }
    
    private func addToDatabase(_ city: City) {
        var postData = [String: AnyObject]()
        
        postData["name"] = city.name as AnyObject
        postData["latitude"] = city.latitude as AnyObject
        postData["longitude"] = city.longitude as AnyObject
        postData["note"] = city.note as AnyObject
        
        ref.child("\(uid)/cities").childByAutoId().setValue(postData)
    }
    
    func removeCity(at index: Int) {
        let city = cities[index]
        guard let id = city.id else {
            return
        }
        ref.child("\(uid)/cities/\(String(describing: id))").removeValue()
        cities.remove(at: index)
    }
    
    func updateCity(city: City) {
        for index in 0 ..< cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
            }
        }
        guard let id = city.id else {
            return
        }
        ref.child("\(uid)/cities/\(String(describing: id))/note").setValue(city.note)
    }
    
    // MARK: - Private functions
    
    private func getLocations() {
        ref.child("\(uid)/cities").observeSingleEvent(of: .value) { (snapshot) in
            guard let cityList = snapshot.value as? [String: AnyObject] else {
                return
            }
            
            cityList.forEach { cityInfo in
                let id = cityInfo.key
                let name = cityInfo.value["name"] as! String
                let latitude = cityInfo.value["latitude"] as! Double
                let longitude = cityInfo.value["longitude"] as! Double
                let note = cityInfo.value["note"] as! String
                
                let city = City(id: id, name: name, latitude: latitude, longitude: longitude, note: note)
                
                self.cities.append(city)
            }
            
            DispatchQueue.main.async {
                self.delegate?.didFetchCities()
            }
        }
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
