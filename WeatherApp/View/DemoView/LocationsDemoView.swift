//
//  LocationsDemoView.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

class LocationsDemoView: UIView {
    // MARK: - Properties
    
    private let infoLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
        setupLabel()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupImage() {
        let image = UIImage(named: "screen1")
        imageView.image = image
    }
    
    private func setupLabel() {
        infoLabel.font = UIFont.systemFont(ofSize: Padding.f20)
        infoLabel.backgroundColor = .clear
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        infoLabel.text = "Tap the + in the upper right corner to add a new location, then you can access it by tapping the location's name."
    }
    
    private func setupUI() {
        addSubview(infoLabel)
        addSubview(imageView)

        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h100)
            $0.width.equalTo(Height.h300)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.f40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h400)
            $0.width.equalTo(Height.h220)
        }
    }
}
