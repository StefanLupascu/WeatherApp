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
    let mapView = MapView()
    private let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        navigationItem.largeTitleDisplayMode = .never
        
        setupUI()
        setupGesture()        
    }
    
    // MARK: - Private Functions
    
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
            
//            print("\(String(describing: locationName))")
            DispatchQueue.main.async {
                completion(locationName, nil)
            }
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
    
    private func showAlert() {
        let alert = UIAlertController(title: "Error", message: "No city found at this location", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setting up actions
    
    @objc func done(sender: UIButton) {
        showActivityIndicator()
        
        guard let cityAnnotation = mapView.map.annotations.first else {
            return
        }

        getCityAt(latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude) { [weak self] (cityName, error) in
            
            guard cityName != nil else {
                self?.activityIndicator.stopAnimating()
                self?.showAlert()
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
