//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 25/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import FirebaseAuth
import SnapKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private let keyboardHeight: CGFloat = 325
    
    private let logoImageView = UIImageView()
    private let userTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupButtons()
        setupTextfields()
        setupGesture()
        setupUI()
    }

    // MARK: - Private Functions
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func loginButtonTapped() {
        guard let username = userTextfield.text,
            let password = passwordTextfield.text else {
                return
        }
        
        self.showActivityIndicator()
        Auth.auth().signIn(withEmail: username, password: password) { (user, error) in
            if error != nil {
                self.login(validated: false)
            } else {
                self.login(validated: true)
            }
        }
    }
    
    @objc private func registerButtonTapped() {
        let registerViewController = RegisterViewController()
        present(registerViewController, animated: false)
    }
    
    private func showActivityIndicator() {
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
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
        passwordTextfield.layer.cornerRadius = Height.h10
    }
    
    private func setupButtons() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        loginButton.layer.cornerRadius = Height.h10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        registerButton.layer.cornerRadius = Height.h10
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        logoImageView.image = UIImage(named: "logo")
        
        view.addSubview(logoImageView)
        view.addSubview(userTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
        }
        
        userTextfield.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.p200)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        passwordTextfield.snp.makeConstraints {
            $0.top.equalTo(userTextfield.snp.bottom).offset(Padding.p5)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextfield.snp.bottom).offset(Padding.p20)
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(Padding.p5)
            $0.height.equalTo(Height.h50)
            $0.leading.equalToSuperview().offset(Padding.p50)
            $0.trailing.equalToSuperview().offset(-Padding.p50)
        }
    }
    
    func login(validated: Bool) {
        if validated {
            let viewModel = LocationsViewModel()
            let vc = LocationsViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: vc)
            
            present(navigationController, animated: true)
        }
        else {
            presentAlert(message: "Login Failed!")
            activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Keyboard Handling
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        userTextfield.snp.updateConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.p180 - keyboardHeight / 2 )
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
