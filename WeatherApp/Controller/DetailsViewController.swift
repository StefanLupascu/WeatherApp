//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var city: City
    var cityView = CityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        self.view = cityView
        
        self.cityView.backButton.addTarget(self, action: "goBack:", for: .touchUpInside)
        self.cityView.nameLabel.text = city.name
        self.cityView.temperatureLabel.text = city.details.temperature
        self.cityView.populationLabel.text = String(city.details.population)
        self.cityView.setupViews()
    }
    
    func goBack(sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
