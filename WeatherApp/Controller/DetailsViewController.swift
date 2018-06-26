//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties and Initialization
    
    var city: City
    var cityView = CityView()
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = cityView
        navigationItem.title = "Information"
        
        print("\(city.name)")
        
        self.cityView.nameLabel.text = city.name
        self.cityView.temperatureLabel.text = city.details.temperature
        self.cityView.populationLabel.text = String(city.details.population)
        self.cityView.notesTextView.text = city.notes
        self.cityView.setupViews()
    }

}
