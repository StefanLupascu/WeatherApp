//
//  LocationsDemoViewController.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class LocationsDemoViewController: UIViewController {
    // MARK: - Properties
    
    private let locationsDemoView = LocationsDemoView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = locationsDemoView
        view.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
    }
}
