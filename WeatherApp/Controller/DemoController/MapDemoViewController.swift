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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = mapDemoView
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }

}
