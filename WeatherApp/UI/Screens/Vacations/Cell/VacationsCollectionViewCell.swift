//
//  VacationCollectionViewCell.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class VacationsCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
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
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        layer.cornerRadius = 15
        
        setupTitleLabel()
        setupDateLabel()
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Vacation"
        titleLabel.textColor = .white
        titleLabel.shadowColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f15)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupDateLabel() {
        dateLabel.text = "DD.MM.YYYY"
        dateLabel.textColor = .white
        dateLabel.shadowColor = .black
        dateLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f20)
            $0.centerX.equalToSuperview()
        }
    }
}
