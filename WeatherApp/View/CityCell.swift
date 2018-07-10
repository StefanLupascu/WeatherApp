//
//  CityCell.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class CityCell: UITableViewCell {
    // MARK: - Properties
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(Padding.f25)
        return label
    }()
    
    // MARK: - Init

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        addSubview(nameLabel)
        
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: Padding.f10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.f10).isActive = true
    }
    
}
