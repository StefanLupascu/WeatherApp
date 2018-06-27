//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Stefan on 25/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewDelegate: class {
    func didRecieveNewWeatherData(city: City)
}

class MapViewController: UIViewController {

    typealias CityNameCompletion = (String?, DataManagerError?) -> Void
    
    // MARK: - Properties and Initialization
    
    var delegate: MapViewDelegate?
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        navigationItem.largeTitleDisplayMode = .never
        
        setupUI()
        setupGesture()
        
    }
    
    // MARK: - Setting up UI elements
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        self.mapView.addGestureRecognizer(gesture)
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(sender:)))
        button.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue",size: 20)!,
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupUI() {
        self.view.addSubview(mapView)
        mapView.frame = self.view.frame
    }
    
    private func getCityAt(latitude: Double, longitude: Double, completion: @escaping CityNameCompletion){
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) in
            
            let placeArray = placemarks as [CLPlacemark]?
            
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            guard let locationName = placeMark.locality else {
                completion(nil, .failedRequest)
                return
            }
            
            print("\(String(describing: locationName))")
            DispatchQueue.main.async {
                completion(placeMark.locality, nil)
            }
        }
    }
    
    // MARK: - Setting up actions
    
    @objc func done(sender: UIButton) {
        guard let cityAnnotation = mapView.map.annotations.first else {
            return
        }
        
        // TODO: Geocoding/Reverse geocoding
//        let cityName = getCityAt(latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude)

        getCityAt(latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude) { [weak self] (cityName, error) in
            
            guard let name = cityName else {
                return
            }
            
            let city = City(name: name, latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude)
            
            self?.delegate?.didRecieveNewWeatherData(city: city)
            
            self?.mapView.map.removeAnnotations((self?.mapView.map.annotations)!)
            self?.navigationItem.rightBarButtonItem = nil
            self?.navigationController?.popViewController(animated: true)
        }

    }
    
    @objc func addPin(sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView.map)
        let locationCoordinates = mapView.map.convert(location, toCoordinateFrom: mapView.map)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        
        mapView.map.removeAnnotations(mapView.map.annotations)
        mapView.map.addAnnotation(annotation)
        
        setupButton()
    }
}
