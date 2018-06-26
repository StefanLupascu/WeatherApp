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

    // MARK: - Properties and Initialization
    
    var weatherInfo = String()
    var delegate: MapViewDelegate?
    
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)
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
    
    // MARK: - Setting up actions
    
    @objc func done(sender: UIButton!) {
        //print("\(weatherInfo)")
        let city = dataManager.addWeatherInfo()
//        print("\(city.name)")
//        print("\(city.temperature)")
        delegate?.didRecieveNewWeatherData(city: city)
        mapView.map.removeAnnotations(mapView.map.annotations)
        navigationItem.rightBarButtonItem = nil
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addPin(sender: UITapGestureRecognizer!) {
        
        let location = sender.location(in: mapView.map)
        let locationCoordinates = mapView.map.convert(location, toCoordinateFrom: mapView.map)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locationCoordinates
        mapView.map.removeAnnotations(mapView.map.annotations)
        mapView.map.addAnnotation(annotation)
        dataManager.weatherDataForLocation(location: locationCoordinates) { (response, error) in
            
            self.weatherInfo = String(describing: response)
        }
        
        setupButton()
    }
    
}
