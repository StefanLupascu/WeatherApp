//
//  MapDemoViewController.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class MapDemoViewController: UIViewController {
    // MARK: - Properties
    
    private let mapDemoView = MapDemoView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapDemoView.delegate = self
        view = mapDemoView
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
}

// MARK: - MapDemoViewDelegate

extension MapDemoViewController: MapDemoViewDelegate {
    func presentLocations() {
        let viewModel = CityViewModel()
        let vc = LocationsViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        
        present(navigationController, animated: true)
    }
}
