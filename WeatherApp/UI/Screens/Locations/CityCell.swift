//
//  CityCell.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class CityCell: UITableViewCell {
    // MARK: - Properties
    
    let nameLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p10)
            $0.leading.equalToSuperview().offset(Padding.p30)
            $0.bottom.equalToSuperview().offset(-Padding.p10)
        }
        
        nameLabel.font = UIFont.systemFont(ofSize: Padding.p25)
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
    }
}
