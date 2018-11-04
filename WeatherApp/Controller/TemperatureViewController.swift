//
//  TemperatureViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class TemperatureViewController: UIViewController {
    // MARK: - Properties
    
    private let temperatureView = TemperatureView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        temperatureView.temperature = -30
        view = temperatureView
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        
    }
}
