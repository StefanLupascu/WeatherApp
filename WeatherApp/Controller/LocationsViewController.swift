////
////  LocationsViewController.swift
////  WeatherApp
////
////  Created by Stefan on 22/06/2018.
////  Copyright © 2018 Stefan. All rights reserved.
////

import UIKit
import CoreData

final class LocationsViewController: UITableViewController, UIGestureRecognizerDelegate {
    // MARK: Properties
    
    private var cities = [City]()
    private let cellId = "cellId"
    
    private let mapViewController = MapViewController()
    private let dataManager = DataManager()
    private let activityIndicator = UIActivityIndicatorView()
    private let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cities"
        
        tableView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
        navigationItem.hidesBackButton = true
        
        mapViewController.delegate = self
        setupButton()
        setupSearchBar()
        getData()
    }
    
    // MARK: - Table view manipulation
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetails(for: cities[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CityCell
        cityCell.nameLabel.text = cities[indexPath.row].name
        return cityCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(deleteIndex: indexPath)
        }
    }
    
    // MARK: - Private Functions
    
    @objc private func goToMap(sender: UIButton) {
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    private func setupSearchBar() {
        searchBar.tintColor = .white
        searchBar.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
    
    private func showActivityIndicator() {
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func delete(deleteIndex: IndexPath) {
        PersistenceService.context.delete(cities[deleteIndex.row])
        cities.remove(at: deleteIndex.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [deleteIndex], with: .automatic)
        tableView.endUpdates()
        
        PersistenceService.saveContext()
    }
    
    private func presentDetails(for city: City) {
        showActivityIndicator()
        
        dataManager.weatherDetailsFor(latitude: city.latitude, longitude: city.longitude) { [weak self](details, error) in
            guard let strongSelf = self, let details = details else {
                return
            }
            let updatedCity = strongSelf.update(city: city, with: details)
            let detailsViewController = DetailsViewController(city: updatedCity)
            detailsViewController.delegate = self
            strongSelf.navigationController?.pushViewController(detailsViewController, animated: true)
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @discardableResult private func update(city: City, with details: Detail) -> City {
        guard let index = cities.index(of: city) else {
            fatalError("Sanity check")
        }
        
        cities[index].details = details
        
        return cities[index]
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToMap(sender:)))
        navigationItem.rightBarButtonItem = button
    }
    
    private func updateCity(city: City) {
        for index in 0..<cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
            }
        }
    }
}

// MARK: - Extensions

extension LocationsViewController: MapViewDelegate {
    func didRecieveNewWeatherData(city: City) {
        cities.append(city)

        tableView.reloadData()
        PersistenceService.saveContext()
    }
}

extension LocationsViewController: DetailsViewDelegate {
    func didUpdateNote(city: City) {
        updateCity(city: city)
        PersistenceService.saveContext()
    }
}
