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
    func didRecieveNewWeatherData(for city: City)
}

class MapViewController: UIViewController {
    // MARK: - Properties
    
    var delegate: MapViewDelegate?
    var location = CLLocationCoordinate2DMake(44.83664488641497, 26.320432662963867)
    
    private let mapView = MKMapView()
    private let manager = LocationManager()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Base Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Map"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(addPin(sender:)))
        mapView.addGestureRecognizer(tap)
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(sender:)))
        button.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Helvetica Neue",size: Padding.p20)!,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupMapView()
        setupGesture()
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        mapView.setRegion(MKCoordinateRegion.init(center: location, latitudinalMeters: 900000, longitudinalMeters: 900000), animated: true)
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
        guard let cityAnnotation = mapView.annotations.first else {
            return
        }
        
        showActivityIndicator()

        manager.getCityAt(latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude) { [weak self] (cityName, countryName, error) in
            guard let self = self else { return }
            
            guard let name = cityName else {
                self.activityIndicator.stopAnimating()
                self.showAlert(message: "No city found at this location")
                return
            }
            
            let city = City(name: name, latitude: cityAnnotation.coordinate.latitude, longitude: cityAnnotation.coordinate.longitude, note: "")
            
            self.delegate?.didRecieveNewWeatherData(for: city)
            
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.navigationItem.rightBarButtonItem = nil
            self.navigationController?.popViewController(animated: true)
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc func addPin(sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        let locationCoordinates = mapView.convert(location, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinates
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        setupButton()
    }
}
