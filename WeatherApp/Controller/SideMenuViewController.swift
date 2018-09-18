//
//  SideMenuViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 18/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

final class SideMenuViewController: UIViewController {
    // MARK: - Properties
    
    private let sideMenuView = SideMenuView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.addSubview(sideMenuView)
        
        sideMenuView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(200)
            $0.leading.equalToSuperview().offset(-200)
        }
    }
}
