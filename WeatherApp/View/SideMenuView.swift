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
    func seeTutorial()
    func openMap()
    func logout()
}

final class SideMenuView: UIView {
    // MARK: - Properties
    
    var delegate: SideMenuViewDelegate?
    
    private let titleLabel = UILabel()
    private let tutorialButton = UIButton()
    private let logoutButton = UIButton()
    private let mapButton = UIButton()
    
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
    
    @objc private func openMap() {
        delegate?.openMap()
    }
    
    @objc private func logout() {
        delegate?.logout()
    }
    
    private func setupLabels() {
        titleLabel.textColor = .white
        titleLabel.text = "Options"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    private func setupButtons() {
        tutorialButton.layer.cornerRadius = 10
        tutorialButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tutorialButton.setTitle("See Tutorial", for: .normal)
        tutorialButton.addTarget(self, action: #selector(seeTutorial), for: .touchUpInside)
        
        mapButton.layer.cornerRadius = 10
        mapButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        mapButton.setTitle("Open Map", for: .normal)
        mapButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        
        logoutButton.layer.cornerRadius = 10
        logoutButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        addSubview(titleLabel)
        addSubview(tutorialButton)
        addSubview(mapButton)
        addSubview(logoutButton)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f50)
            $0.centerX.equalToSuperview()
        }
        
        tutorialButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h200)
            $0.height.equalTo(Height.h50)
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalTo(tutorialButton.snp.bottom).offset(Padding.f5)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h200)
            $0.height.equalTo(Height.h50)
        }
        
        logoutButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.f75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h200)
            $0.height.equalTo(Height.h50)
        }
    }
}
