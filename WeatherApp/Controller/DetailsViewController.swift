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
        view.backgroundColor = .blue
        
        setupViews()
    }
    
    var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: UIControlState.normal)
        
        return button
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "City details"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    func setupViews() {
        self.view.addSubview(backButton)
        self.view.addSubview(nameLabel)
    }
    
    init(city: City) {
        self.city = city
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
