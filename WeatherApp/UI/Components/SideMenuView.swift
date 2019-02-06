//
//  SideMenuView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 18/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

protocol SideMenuViewDelegate {
    func seeTutorial()
    func goToCities()
    func goToPredictions()
    func logout()
}

final class SideMenuView: UIView {
    // MARK: - Properties
    
    var delegate: SideMenuViewDelegate?
    
    let userLabel = UILabel()
    private let titleLabel = UILabel()
    private let tutorialButton = UIButton()
    private let logoutButton = UIButton()
    private let citiesButton = UIButton()
    private let vacationButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
        setupLabels()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    @objc private func seeTutorial() {
        delegate?.seeTutorial()
    }
    
    @objc private func goToCities() {
        delegate?.goToCities()
    }
    
    @objc private func goToPredictions() {
        delegate?.goToPredictions()
    }
    
    @objc private func logout() {
        delegate?.logout()
    }
    
    private func setupLabels() {
        userLabel.textColor = .white
        userLabel.text = "username"
        userLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        titleLabel.textColor = .white
        titleLabel.text = "Options"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private func setupButtons() {
        tutorialButton.layer.cornerRadius = 10
        tutorialButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tutorialButton.setTitle("See Tutorial", for: .normal)
        tutorialButton.addTarget(self, action: #selector(seeTutorial), for: .touchUpInside)
        
        citiesButton.layer.cornerRadius = 10
        citiesButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        citiesButton.setTitle("Cities", for: .normal)
        citiesButton.addTarget(self, action: #selector(goToCities), for: .touchUpInside)
        
        vacationButton.layer.cornerRadius = 10
        vacationButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        vacationButton.setTitle("Predictions", for: .normal)
        vacationButton.addTarget(self, action: #selector(goToPredictions), for: .touchUpInside)
        
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        addSubview(userLabel)
        addSubview(titleLabel)
        addSubview(tutorialButton)
        addSubview(citiesButton)
        addSubview(vacationButton)
        addSubview(logoutButton)
        
        userLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(Padding.f20)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(userLabel.snp.bottom).offset(Padding.f20)
            $0.centerX.equalToSuperview()
        }
        
        tutorialButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
        
        citiesButton.snp.makeConstraints {
            $0.top.equalTo(tutorialButton.snp.bottom).offset(Padding.f5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
        
        vacationButton.snp.makeConstraints {
            $0.top.equalTo(citiesButton.snp.bottom).offset(Padding.f5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.f75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h250)
            $0.height.equalTo(Height.h50)
        }
    }
}
