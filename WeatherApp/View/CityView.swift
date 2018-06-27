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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    let humidityLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(20)
        
        return label
    }()
    
    let summaryLabel: UILabel = {
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
        addSubview(humidityLabel)
        addSubview(pressureLabel)
        addSubview(summaryLabel)
        addSubview(notesTextView)
        
        //nameLabel setup
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //temperatureLabel setup
        temperatureLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //humidityLabel setup
        humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 20).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //pressureLabel setup
        pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20).isActive = true
        pressureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        pressureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //summaryLabel setup
        summaryLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: 20).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //notesTextView setup
        notesTextView.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 180).isActive = true
        notesTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        notesTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    
    }
    
}
