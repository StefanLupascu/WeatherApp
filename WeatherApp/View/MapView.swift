//
//  MapView.swift
//  WeatherApp
//
//  Created by Stefan on 25/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    let map = MKMapView()
    
    let mapLabel: UILabel = {
        let label = UILabel()
        label.text = "Test Map"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupViews() {
        
        addSubview(map)

        map.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
      
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2DMake(48.83664488641497, 2.320432662963867)
        map.setRegion(MKCoordinateRegionMakeWithDistance(location, 50000, 50000), animated: true)
        
        let pin = PinAnnotation(title: "Eiffel Tower", coordinate: location)
        map.addAnnotation(pin)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        map.translatesAutoresizingMaskIntoConstraints = false
        
        setupMap()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}