//
//  PressureView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class PressureView: UICollectionViewCell {
    // MARK: - Properties
    
    var pressure: Double = 0 {
        didSet {
            pressureLabel.text = "\(Int(pressure))"
        }
    }

    private let titleLabel = UILabel()
    private let pressureLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        setupTitleLabel()
        setupPressureLabel()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f75)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.text = "Pressure:"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
    }
    
    private func setupPressureLabel() {
        addSubview(pressureLabel)
        
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f10)
            $0.centerX.equalToSuperview()
        }
        
        pressureLabel.textAlignment = .center
        pressureLabel.font = UIFont.boldSystemFont(ofSize: 24)
        pressureLabel.textColor = .white
    }
}
