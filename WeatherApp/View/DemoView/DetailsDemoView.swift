//
//  DetailsDemoView.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

class DetailsDemoView: UIView {
    // MARK: - Properties
    
    private let infoLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
        setupTextview()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupImage() {
        let image = UIImage(named: "screen3")
        imageView.image = image
    }
    
    private func setupTextview() {
        infoLabel.textColor = .black
        infoLabel.font = UIFont.systemFont(ofSize: Padding.f20)
        infoLabel.backgroundColor = .clear
        infoLabel.numberOfLines = 0
        infoLabel.text = "In the details screen you can check details about the weather of the selected location. You can also write a note about it."
    }
    
    private func setupUI() {
        addSubview(infoLabel)
        addSubview(imageView)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
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
