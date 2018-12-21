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
            summaryLabel.text = summary
        }
    }
    
    private let titleLabel = UILabel()
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
        
        setupTitleLabel()
        setupSummaryLabel()
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f75)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.text = "Summary: "
    }
    
    private func setupSummaryLabel() {
        addSubview(summaryLabel)
        
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f30)
            $0.leading.equalToSuperview().offset(Padding.f20)
            $0.trailing.equalToSuperview().offset(-Padding.f20)
        }
        
        summaryLabel.textAlignment = .center
        summaryLabel.textColor = .white
        summaryLabel.font = UIFont.systemFont(ofSize: 20)
        summaryLabel.numberOfLines = 0
    }
}
