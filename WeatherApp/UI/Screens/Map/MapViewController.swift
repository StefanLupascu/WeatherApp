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
    
    // MARK: - Properties
    
    var delegate: MapViewDelegate?
    private let mapView = MapView()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        
        setupUI()
        setupGesture()        
    }
    
    // MARK: - Private Functions
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        mapView.addGestureRecognizer(gesture)
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(sender:)))
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Helvetica Neue",size: Padding.f20)!,
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupMapView()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
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
            
            guard let countryName = placeMark.country else {
                completion(nil, .failedRequest)
                return
            }
            
            print(countryName)
            
            DispatchQueue.main.async {
                completion(locationName, nil)
            }
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setting up actions
    
    @objc func done(sender: UIButton) {
//        showActivityIndicator()
        
        guard let cityAnnotation = mapView.map.annotations.first else {
            return
        }
        
        guard Reachability.isConnectedToNetwork() else {
            //            showAlert(message: "Cannot get city location if not connected to internet!")
            let city = City(name: "Custom name \(cityAnnotation.coordinate.latitude)", latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude, note: "")
            delegate?.didRecieveNewWeatherData(city: city)
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        showActivityIndicator()

        getCityAt(latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude) { [weak self] (cityName, error) in
            
            guard cityName != nil else {
                self?.activityIndicator.stopAnimating()
                self?.showAlert(message: "No city found at this location")
                return
            }
            
            guard let name = cityName else {
                return
            }
            
            let city = City(context: PersistenceService.context)
            city.name = name
            city.latitude = cityAnnotation.coordinate.latitude
            city.longitude = cityAnnotation.coordinate.longitude
            city.note = ""
            
            self?.delegate?.didRecieveNewWeatherData(city: city)
            
            self?.mapView.map.removeAnnotations((self?.mapView.map.annotations)!)
            self?.navigationItem.rightBarButtonItem = nil
            self?.navigationController?.popViewController(animated: true)
            
            self?.activityIndicator.stopAnimating()
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
