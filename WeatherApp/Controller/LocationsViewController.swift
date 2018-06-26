//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class LocationsViewController: UICollectionViewController {
    
    // MARK: - Properties and Initialization
    
//    var cities: [City] = {
//        var cityList = [City]()
//        for index in 1...15 {
//            let details = Detail(temperature: "randomTemp", population: index*10)
//            let city = City(name: "City\(index)", details: details, notes: "random notes for City\(index)")
//
//            cityList.append(city)
//        }
//
//        return cityList
//    }()
    
    var cities: [City] = {
        var cityList = [City]()
        
        return cityList
    }()
    
    var mapViewController = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.title = "Cities"
        setupButton()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(CityCell.self, forCellWithReuseIdentifier: "cellId")
        
        mapViewController.delegate = self
    }
    
    // MARK: - Collection view manipulation
    
    @objc func goToMap(sender: UIButton) {
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController(city: cities[indexPath.item]) as DetailsViewController
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cityCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CityCell
        //cityCell.nameLabel.text = cities[indexPath.item].name
        
        var name = cities[indexPath.item].name.split(separator: "/")
        cityCell.nameLabel.text = String(name[1])
        
        return cityCell
    }
    
    // MARK: - Setting up add button
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(goToMap(sender:)))
        button.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue",size: 35)!,
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }

}

extension LocationsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}

extension LocationsViewController: MapViewDelegate {
    
    func didRecieveNewWeatherData(city: City) {
        cities.append(city)
        collectionView?.reloadData()
        //saveToDatabase
    }
    
    
}
