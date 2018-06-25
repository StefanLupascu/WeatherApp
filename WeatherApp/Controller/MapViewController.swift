//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Stefan on 25/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    let map = MKMapView()
    let mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Map"
        
        setupUI()
        setupButton()
                
    }
    
    func setupButton() {
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(sender:)))
        button.setTitleTextAttributes([
            NSAttributedStringKey.font: UIFont(name: "Helvetica Neue",size: 20)!,
            NSAttributedStringKey.foregroundColor: UIColor.blue,
            ], for: .normal)
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func done(sender: UIButton!) {
        
    }
    
    func setupUI() {
        self.view.addSubview(mapView)
        mapView.frame = self.view.frame
    }
    
}
