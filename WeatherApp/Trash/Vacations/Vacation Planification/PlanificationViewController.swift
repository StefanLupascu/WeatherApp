//
//  PlanificationViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 20/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class PlanificationViewController: UIViewController {
    // MARK: - Properties
    
    private let nameTextfield = UITextField()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupNavigationBar()
        setupNameTextfield()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Planification"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupNameTextfield() {
        nameTextfield.placeholder = "Vacation Name"
        nameTextfield.textAlignment = .center
        nameTextfield.backgroundColor = .white
        nameTextfield.borderStyle = .roundedRect
        
        view.addSubview(nameTextfield)
        nameTextfield.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.f40)
            $0.leading.equalToSuperview().offset(Padding.f40)
            $0.trailing.equalToSuperview().offset(-Padding.f40)
        }
    }
}
