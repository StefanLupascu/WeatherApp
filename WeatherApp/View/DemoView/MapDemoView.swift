//
//  MapDemoView.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

protocol MapDemoViewDelegate {
    func presentLocations()
}

class MapDemoView: UIView {
    // MARK: - Properties
    
    var delegate: MapDemoViewDelegate?
    
    private let infoLabel = UILabel()
    private let imageView = UIImageView()
    private let startButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupImage()
        setupTextview()
        setupButton()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    @objc private func goToApp() {
        delegate?.presentLocations()
    }
    
    private func setupImage() {
        let image = UIImage(named: "screen4")
        imageView.image = image
    }
    
    private func setupTextview() {
        infoLabel.font = UIFont.systemFont(ofSize: Padding.p20)
        infoLabel.backgroundColor = .clear
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        infoLabel.text = "Use the map to navigate and tap anywhere on it to place a pin. After placing the pin, tap on the 'Done' button to get the location."
    }
    
    private func setupButton() {
        startButton.setTitle("Go to App", for: .normal)
        startButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(goToApp), for: .touchUpInside)
    }
    
    private func setupUI() {
        addSubview(startButton)
        addSubview(infoLabel)
        addSubview(imageView)
        
        startButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h200)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(startButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h100)
            $0.width.equalTo(Height.h300)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h400)
            $0.width.equalTo(Height.h220)
        }
    }
}
