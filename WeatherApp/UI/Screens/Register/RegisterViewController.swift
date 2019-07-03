//
//  RegisterViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 06/02/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

final class RegisterViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel: RegisterViewModel
    
    private let logoImageView = UIImageView()
    private let userTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let nameTextfield = UITextField()
    private let registerButton = UIButton()
    private let cancelButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        setupGesture()
        setupLogoImageView()
        setupUserTextfield()
        setupPasswordTextfield()
        setupNameTextfield()
        setupRegisterButton()
        setupCancelButton()
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
        
        logoImageView.image = UIImage(named: viewModel.imageName)
    }
    
    private func setupUserTextfield() {
        view.addSubview(userTextfield)
        userTextfield.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.p200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        userTextfield.placeholder = viewModel.emailPlaceholder
        userTextfield.backgroundColor = .white
        userTextfield.layer.borderColor = UIColor.black.cgColor
        userTextfield.textAlignment = .center
        userTextfield.layer.cornerRadius = Height.h10
    }
    
    private func setupPasswordTextfield() {
        view.addSubview(passwordTextfield)
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(userTextfield.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        passwordTextfield.placeholder = viewModel.passwordPlaceholder
        passwordTextfield.backgroundColor = .white
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.layer.borderColor = UIColor.black.cgColor
        passwordTextfield.textAlignment = .center
        passwordTextfield.layer.cornerRadius = Height.h10
    }
    
    private func setupNameTextfield() {
        view.addSubview(nameTextfield)
        nameTextfield.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        nameTextfield.placeholder = viewModel.aliasPlaceholder
        nameTextfield.backgroundColor = .white
        nameTextfield.layer.borderColor = UIColor.black.cgColor
        nameTextfield.textAlignment = .center
        nameTextfield.layer.cornerRadius = Height.h10
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints {
            $0.top.equalTo(nameTextfield.snp.bottom).offset(Padding.p20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        registerButton.setTitle(viewModel.registerText, for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        registerButton.layer.cornerRadius = Height.h10
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func setupCancelButton() {
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(registerButton.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        cancelButton.setTitle(viewModel.cancelText, for: .normal)
        cancelButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        cancelButton.layer.cornerRadius = Height.h10
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func registerButtonTapped() {
        guard let username = userTextfield.text,
                let password = passwordTextfield.text,
                let name = nameTextfield.text else {
                return
        }
        
        guard username != "",
                password != "",
                name != "" else {
                presentAlert(message: "All fields must be completed!")
                return
        }
        
        Auth.auth().createUser(withEmail: username, password: password) { (authResult, error) in
            guard error == nil else {
                self.presentAlert(message: "Register Error")
                return
            }
            
            guard let user = authResult?.user else {
                return
            }
            let userId = user.uid
            
            Database.database().reference().child("\(userId)/name").setValue(name)
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    // MARK: - Keyboard Handling
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        userTextfield.snp.updateConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.p5)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillDisappear(_ notification: NSNotification) {
        userTextfield.snp.updateConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.p200)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
}
