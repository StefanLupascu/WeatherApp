//
//  SideMenuView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 18/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

protocol SideMenuViewDelegate {
    func goToCities()
    func goToPredictions()
    func goToCurrentLocation()
    func logout()
}

final class SideMenuView: UIView {
    // MARK: - Properties
    
    var delegate: SideMenuViewDelegate?
    
    let userLabel = UILabel()
    private let titleLabel = UILabel()
    private let logoutButton = UIButton()
    private let citiesButton = UIButton()
    private let predictionsButton = UIButton()
    private let currentWeatherButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    @objc private func goToCities() {
        delegate?.goToCities()
    }
    
    @objc private func goToPredictions() {
        delegate?.goToPredictions()
    }
    
    @objc private func goToCurrentLocation() {
        delegate?.goToCurrentLocation()
    }
    
    @objc private func logout() {
        delegate?.logout()
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        setupUserLabel()
        setupTitleLabel()
        setupCitiesButton()
        setupPredictionsButton()
        setupCurrentWeatherButton()
        setupLogoutButton()
    }
    
    private func setupUserLabel() {
        userLabel.textColor = .white
        userLabel.text = "username"
        userLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        addSubview(userLabel)
        userLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.text = "Options"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(userLabel.snp.bottom).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupCitiesButton() {
        citiesButton.layer.cornerRadius = 10
        citiesButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        citiesButton.setTitle("Cities", for: .normal)
        citiesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        citiesButton.addTarget(self, action: #selector(goToCities), for: .touchUpInside)
        
        addSubview(citiesButton)
        citiesButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.p40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
    }
    
    private func setupPredictionsButton() {
        predictionsButton.layer.cornerRadius = 10
        predictionsButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        predictionsButton.setTitle("Predictions", for: .normal)
        predictionsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        predictionsButton.addTarget(self, action: #selector(goToPredictions), for: .touchUpInside)
        
        addSubview(predictionsButton)
        predictionsButton.snp.makeConstraints {
            $0.top.equalTo(citiesButton.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
    }
    
    private func setupCurrentWeatherButton() {
        currentWeatherButton.layer.cornerRadius = 10
        currentWeatherButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        currentWeatherButton.setTitle("Current Location", for: .normal)
        currentWeatherButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        currentWeatherButton.addTarget(self, action: #selector(goToCurrentLocation), for: .touchUpInside)
        
        addSubview(currentWeatherButton)
        currentWeatherButton.snp.makeConstraints {
            $0.top.equalTo(predictionsButton.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
    }
    
    private func setupLogoutButton() {
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
    }
}
