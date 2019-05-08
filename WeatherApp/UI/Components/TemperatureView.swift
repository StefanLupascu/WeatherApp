//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class TemperatureView: UICollectionViewCell {
    // MARK: - Properties
    
    var temperature: Double = 0 {
        didSet {
            temperatureLabel.text = "Temperature:\n\(Int(temperature))ºC"
            animate(temperature: temperature)
        }
    }
    
    private let backgroundBarView = UIView()
    private let trackingView = UIView()
    private let temperatureLabel = UILabel()
    private let negative40Label = UILabel()
    private let zeroLabel = UILabel()
    private let positive40Label = UILabel()
    
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
        
        setupTemperatureLabel()
        setupBackgroundBarView()
        setupNegative40Label()
        setupZeroLabel()
        setupPositive40Label()
        setupTrackingView()
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 24)
        temperatureLabel.numberOfLines = 0
        temperatureLabel.text = "Temperature:\n\(Int(temperature))ºC"
        
        addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p75)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupBackgroundBarView() {
        backgroundBarView.backgroundColor = .gray
        backgroundBarView.layer.cornerRadius = 15
        
        addSubview(backgroundBarView)
        backgroundBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Height.h300)
            $0.height.equalTo(Height.h40)
        }
    }
    
    private func setupNegative40Label() {
        negative40Label.textAlignment = .center
        negative40Label.textColor = .white
        negative40Label.text = "-40ºC"
        
        addSubview(negative40Label)
        negative40Label.snp.makeConstraints {
            $0.bottom.equalTo(backgroundBarView.snp.top)
            $0.leading.equalTo(backgroundBarView.snp.leading)
        }
    }
    
    private func setupZeroLabel() {
        zeroLabel.textAlignment = .center
        zeroLabel.textColor = .white
        zeroLabel.text = "0ºC"
        
        addSubview(zeroLabel)
        zeroLabel.snp.makeConstraints {
            $0.bottom.equalTo(backgroundBarView.snp.top)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupPositive40Label() {
        positive40Label.textAlignment = .center
        positive40Label.textColor = .white
        positive40Label.text = "40ºC"
        
        addSubview(positive40Label)
        positive40Label.snp.makeConstraints {
            $0.bottom.equalTo(backgroundBarView.snp.top)
            $0.trailing.equalTo(backgroundBarView.snp.trailing)
        }
    }
    
    private func setupTrackingView() {
        trackingView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        trackingView.layer.cornerRadius = 15
        
        backgroundBarView.addSubview(trackingView)
        trackingView.snp.makeConstraints {
            $0.leading.height.equalToSuperview()
            $0.trailing.equalTo(backgroundBarView.snp.leading)
        }
    }
    
    private func animate(temperature: Double) {
        let offset = 300 / 80 * (temperature + 40)
        
        trackingView.snp.updateConstraints {
            $0.trailing.equalTo(backgroundBarView.snp.leading).offset(offset)
        }
        UIView.animate(withDuration: 1.2) {
            self.trackingView.layoutIfNeeded()
        }
    }
}
