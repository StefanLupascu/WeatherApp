//
//  PredictionsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 22/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class PredictionsCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let titleLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        backgroundColor = .gray
        layer.cornerRadius = Height.h15
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        
        setupTitleLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .white
        titleLabel.shadowColor = .black
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
