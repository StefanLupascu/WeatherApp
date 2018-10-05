//
//  LoginView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 25/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

protocol LoginViewDelegate: class {
    func login(validated: Bool)
}

final class LoginView: UIView {
    // MARK: - Properties
    
    var delegate: LoginViewDelegate?
    
    private let logoImageView = UIImageView()
    private let userTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let loginButton = UIButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
        setupTextfields()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    @objc private func login() {
        guard let username = userTextfield.text,
            let password = passwordTextfield.text else {
            delegate?.login(validated: false)
            return
        }
        
        guard User.username == username,
            User.password == password else {
                delegate?.login(validated: false)
                return
        }
        
        delegate?.login(validated: true)
    }
    
    private func setupTextfields() {
        userTextfield.placeholder = "Username"
        userTextfield.backgroundColor = .white
        userTextfield.layer.borderColor = UIColor.black.cgColor
        userTextfield.textAlignment = .center
        userTextfield.layer.cornerRadius = 10
        
        passwordTextfield.placeholder = "Password"
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.backgroundColor = .white
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextfield.textAlignment = .center
        passwordTextfield.layer.cornerRadius = 10
    }
    
    private func setupButtons() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        logoImageView.image = UIImage(named: "logo")
        
        addSubview(logoImageView)
        addSubview(userTextfield)
        addSubview(passwordTextfield)
        addSubview(loginButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f75)
            $0.centerX.equalToSuperview()
        }
        
        userTextfield.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f220)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.width.equalTo(Height.h300)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(userTextfield.snp.bottom).offset(Padding.f5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.width.equalTo(Height.h300)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(Padding.f20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.width.equalTo(Height.h300)
        }
    }
}
