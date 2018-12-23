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
        passwordTextfield.layer.cornerRadius = 10
    }
    
    private func setupButtons() {
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        logoImageView.image = UIImage(named: "logo")
        
        view.addSubview(logoImageView)
        view.addSubview(userTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(loginButton)
        
        logoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.f75)
            $0.centerX.equalToSuperview()
        }
        
        userTextfield.snp.makeConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.f200)
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
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.f220 - keyboardHeight / 2 )
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillDisappear(_ notification: NSNotification) {
        userTextfield.snp.updateConstraints {
            $0.top.equalTo(logoImageView.snp.bottom).offset(Padding.f200)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
}
