//
//  MapView.swift
//  WeatherApp
//
//  Created by Stefan on 25/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

final class MapView: UIView {
    // MARK: - Properties
    
    let map = MKMapView()
    var location = CLLocationCoordinate2DMake(44.83664488641497, 26.320432662963867)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        setupMap()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        addSubview(map)

        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
      
    }
    
    private func setupMap() {
        map.setRegion(MKCoordinateRegionMakeWithDistance(location, 900000, 900000), animated: true)
    }
    
}
