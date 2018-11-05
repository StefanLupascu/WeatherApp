//
//  SummaryView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 05/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class SummaryView: UICollectionViewCell {
    // MARK: - Properties
    
    var summary: String = "" {
        didSet {
            summaryLabel.text = "Summary: \n" + summary
        }
    }
    
    private let summaryLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        setupLabel()
    }
    
    private func setupLabel() {
        addSubview(summaryLabel)
        
        summaryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f75)
            $0.centerX.equalToSuperview()
        }
        
        summaryLabel.textAlignment = .center
        summaryLabel.textColor = .white
        summaryLabel.font = UIFont.boldSystemFont(ofSize: 24)
        summaryLabel.numberOfLines = 0
    }
}
