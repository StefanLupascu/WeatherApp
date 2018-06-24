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
        label.text = "City details"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
