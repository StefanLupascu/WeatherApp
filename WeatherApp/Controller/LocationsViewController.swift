//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit
import CoreData

final class LocationsViewController: UICollectionViewController {
    // MARK: - Properties
    
    private var cities = [City]()
    
    private let mapViewController = MapViewController()
    private let dataManager = DataManager()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cities"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CityCell.self, forCellWithReuseIdentifier: "cellId")
        
        mapViewController.delegate = self
        setupButton()
        getData()
    }
    
    // MARK: - Collection view manipulation
    
    @objc func goToMap(sender: UIButton) {
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetails(for: cities[indexPath.item])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CityCell
        cityCell.nameLabel.text = cities[indexPath.item].name
        
        return cityCell
    }
    
    //MARK: - Private Functions
    
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
    
    private func presentDetails(for city: City) {
        showActivityIndicator()
        
        dataManager.weatherDetailsFor(latitude: city.latitude, longitude: city.longitude) { [weak self] (details, error) in
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
        let button = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(goToMap(sender:)))
        button.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue",size: 35)!,
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }
    
    private func updateCity(city: City) {
        for index in 0..<cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
                //print("\(city.note)")
            }
        }
    }

}

//MARK: - Extensions

extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension LocationsViewController: MapViewDelegate {
    func didRecieveNewWeatherData(city: City) {
        cities.append(city)
        collectionView?.reloadData()
        PersistenceService.saveContext()
    }
}

extension LocationsViewController: DetailsViewDelegate {
    func didUpdateNote(city: City) {
        updateCity(city: city)
        collectionView?.reloadData()
        PersistenceService.saveContext()
    }
}
