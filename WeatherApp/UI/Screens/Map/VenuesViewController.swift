//
//  VenuesViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 23/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

final class VenuesViewController: UIViewController {
    // MARK: - Properties
    
    private var isMapSet = false
    private let viewModel: VenuesViewModel
    private let mapView = MKMapView()
    
    // MARK: - Init
    
    init(viewModel: VenuesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        
        setupNavigationBar()
        setupMapView()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Points of Interest"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupMapView() {
        
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func createPin(for venue: Venue) {
        let coordinate = CLLocationCoordinate2DMake(venue.latitude, venue.longitude)
        let pin = PinAnnotation(title: venue.name, coordinate: coordinate)
        
        if !isMapSet {
            isMapSet = true
            mapView.setRegion(MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000), animated: true)
            return
        }
        
        mapView.addAnnotation(pin)
    }
}

// MARK: - VenuesViewModelDelegate

extension VenuesViewController: VenuesViewModelDelegate {
    func showVenues() {
        viewModel.venues.forEach { venue in
            createPin(for: venue)
        }
    }
}
