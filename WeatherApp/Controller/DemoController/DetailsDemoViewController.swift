//
//  DetailsDemoViewController.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class DetailsDemoViewController: UIViewController {
    // MARK: - Proeprties
    
    private let detailsDemoView = DetailsDemoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = detailsDemoView
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }

}
