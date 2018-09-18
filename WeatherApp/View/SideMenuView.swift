//
//  SideMenuView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 18/09/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class SideMenuView: UIView {
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupLabel() {
        titleLabel.textColor = .white
        titleLabel.text = "Favourites"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f40)
            $0.centerX.equalToSuperview()
        }
    }
}
