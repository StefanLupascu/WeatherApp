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
        
        nameLabel.font = UIFont.systemFont(ofSize: Padding.f25)
        nameLabel.textColor = .white
        nameLabel.shadowColor = .black
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f10)
            $0.leading.equalToSuperview().offset(Padding.f30)
            $0.bottom.equalToSuperview().offset(-Padding.f10)
        }
    }
}
