//
//  CityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class CityView: UIView {
    // MARK: - Properties
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        let screensize = UIScreen.main.bounds
        scrollView.contentSize = CGSize(width: screensize.width, height: screensize.height)
        
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(temperatureLabel)
        scrollView.addSubview(humidityLabel)
        scrollView.addSubview(pressureLabel)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(notesTextView)
        
        //scrollView setup
        scrollView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //nameLabel setup
        nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Padding.f5).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.f20).isActive = true
        
        //temperatureLabel setup
        temperatureLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Padding.f20).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.f20).isActive = true
        
        //humidityLabel setup
        humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Padding.f20).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.f20).isActive = true
        
        //pressureLabel setup
        pressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: Padding.f20).isActive = true
        pressureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        pressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.f20).isActive = true
        
        //summaryLabel setup
        summaryLabel.topAnchor.constraint(equalTo: pressureLabel.bottomAnchor, constant: Padding.f20).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        summaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.f20).isActive = true
        
        //notesTextView setup
        notesTextView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: Padding.f20).isActive = true
        notesTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Padding.f20).isActive = true
        notesTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.f20).isActive = true
    }
}
