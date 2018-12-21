//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 25/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private let loginView = LoginView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginView.delegate = self
        view = loginView
        setupGesture()
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
    
    // MARK: - Keyboard Handling
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, view.frame.origin.y == 0 else {
            return
        }
        
        view.frame.origin.y -= keyboardSize.height / 2
    }
    
    @objc private func keyboardWillDisappear(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
}

// MARK: - LoginViewDelegate

extension LoginViewController: LoginViewDelegate {
    func login(validated: Bool) {
        if validated {
//            let viewModel = CityViewModel()
            let viewModel = LocationsViewModel()
            let vc = LocationsViewController(viewModel: viewModel)
            let navigationController = UINavigationController(rootViewController: vc)
            
            present(navigationController, animated: true)
        }
        else {
            presentAlert(message: "Login Failed!")
        }
    }
}
