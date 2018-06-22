//
//  CityCell.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    var cities = CityList()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "City name"
        //label.text = cities[0].name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}

class CityHeaderCell: UICollectionViewCell {
    
    var cities = CityList()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "City header"
        //label.text = cities[0].name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
}
