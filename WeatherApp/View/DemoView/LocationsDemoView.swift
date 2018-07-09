//
//  LocationsDemoView.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class LocationsDemoView: UIView {
    // MARK: - Properties
    
    var demoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        addSubview(demoLabel)
        
        demoLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        demoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 140).isActive = true
        demoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        demoLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        demoLabel.text = "Demo Stuff"
    }
}
