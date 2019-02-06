//
//  MapView.swift
//  WeatherApp
//
//  Created by Stefan on 25/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

final class MapView: UIView {
    // MARK: - Properties
    
    let map = MKMapView()
    var location = CLLocationCoordinate2DMake(44.83664488641497, 26.320432662963867)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        map.setRegion(MKCoordinateRegion.init(center: location, latitudinalMeters: 900000, longitudinalMeters: 900000), animated: true)
        
        addSubview(map)
        map.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
