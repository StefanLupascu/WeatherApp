//
//  NavigationController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 12/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class NavigationController: UIViewController {
    // MARK: - Properties
    
    let sideMenuView = SideMenuView()
    private let rightView = UIView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = .black
        
        sideMenuView.delegate = self
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    @objc private func menuButtonTapped() {
        sideMenuView.snp.updateConstraints {
            $0.leading.equalToSuperview()
        }
        
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 4, options: .curveEaseOut, animations: {
            self.navigationController?.view.layoutIfNeeded()
            self.rightView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        }, completion: nil)
        
        rightView.isUserInteractionEnabled = true
    }
    
    @objc private func dismissSideMenu() {
        sideMenuView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(-Padding.f285)
        }
        
        UIView.animate(withDuration: 0.6) {
            self.navigationController?.view.layoutIfNeeded()
            self.rightView.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        
        rightView.isUserInteractionEnabled = false
    }
    
    private func setupButton() {
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    private func setupUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("\(userId)/name").observeSingleEvent(of: .value) { (snapshot) in
            guard let username = snapshot.value as? String else {
                return
            }
            
            self.sideMenuView.userLabel.text = username
        }
    }
    
    private func setupUI() {
        setupButton()
        setupUser()
        setupRightView()
        setupSideMenuView()
        setupGestures()
    }
    
    private func setupRightView() {
        rightView.backgroundColor = UIColor(white: 0, alpha: 0)
        rightView.isUserInteractionEnabled = false
        
        navigationController?.view.addSubview(rightView)
        rightView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupSideMenuView() {
        navigationController?.view.addSubview(sideMenuView)
        sideMenuView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(-view.frame.width * 0.75)
            $0.width.equalTo(view.frame.width * 0.75)
        }
    }
    
    private func setupGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        leftSwipe.direction = .left
        sideMenuView.addGestureRecognizer(leftSwipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        rightView.addGestureRecognizer(tap)
    }
}

// MARK: - SideMenuViewDelegate

extension NavigationController: SideMenuViewDelegate {
    func seeTutorial() {
        let tutorialVC = DemoPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        present(tutorialVC, animated: true)
    }
    
    func goToCities() {
        let locationsViewController = LocationsViewController(viewModel: LocationsViewModel())
        let vc = UINavigationController(rootViewController: locationsViewController)
        dismissSideMenu()
        self.present(vc, animated: true)
    }
    
    func goToPredictions() {
        let viewModel = LocationsViewModel()
        let predictionsViewController = PredictionsViewController(viewModel: viewModel)
        let vc = UINavigationController(rootViewController: predictionsViewController)
        dismissSideMenu()
        self.present(vc, animated: true)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true)
    }
}
