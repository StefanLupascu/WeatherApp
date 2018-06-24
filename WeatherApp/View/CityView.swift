//
//  CityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class CityView: UIView {

    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "City details"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    var populationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: UIControlState.normal)
        button.isEnabled = true
        
        return button
    }()
    
    func setupViews() {
        backButton.frame = CGRect(x: self.frame.width, y: self.frame.height + 20, width: 100, height: 40)
        nameLabel.frame = CGRect(x: self.frame.width + 20, y: self.frame.height + 80, width: 200, height: 60)
        temperatureLabel.frame = CGRect(x: self.frame.width + 20, y: self.frame.height + 110, width: 200, height: 60)
        populationLabel.frame = CGRect(x: self.frame.width + 20, y: self.frame.height + 140, width: 200, height: 60)

        
        addSubview(nameLabel)
        addSubview(backButton)
        addSubview(temperatureLabel)
        addSubview(populationLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
