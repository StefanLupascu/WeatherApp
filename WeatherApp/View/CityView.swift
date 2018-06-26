//
//  CityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class CityView: UIView {

    // MARK: - Properties and Initialization
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.adjustsFontForContentSizeCategory = true
        textView.isSelectable = true
        textView.isEditable = true
        textView.layer.cornerRadius = 10
        textView.font = UIFont.systemFont(ofSize: 20)
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting up views
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(temperatureLabel)
        addSubview(populationLabel)
        addSubview(notesTextView)
        
        //nameLabel setup
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //temperatureLabel setup
        temperatureLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //populationLabel setup
        populationLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20).isActive = true
        populationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        populationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //notesTextView setup
        notesTextView.topAnchor.constraint(equalTo: populationLabel.bottomAnchor, constant: 20).isActive = true
        notesTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        notesTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    
    }
    
}
