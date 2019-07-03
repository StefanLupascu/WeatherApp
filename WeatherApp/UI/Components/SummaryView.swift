//
//  SummaryView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 05/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

protocol PointsOfInterestViewDelegate: class {
    func showPointsOfInterest()
}

final class SummaryView: UICollectionViewCell {
    // MARK: - Properties
    
    weak var delegate: PointsOfInterestViewDelegate?
    
    var pressure: Double = 0 {
        didSet {
            pressureLabel.text = "\(Int(pressure))"
        }
    }
    
    var summary: String = "" {
        didSet {
            summaryLabel.text = summary
        }
    }
    
    private let summaryTitleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let pressureTitleLabel = UILabel()
    private let pressureLabel = UILabel()
    
    private let pointsOfInterestButton = UIButton()
    
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
        
        setupPressureTitleLabel()
        setupPressureLabel()
        setupSummaryTitleLabel()
        setupSummaryLabel()
        setupPointsOfInterestButton()
    }
    
    private func setupPressureTitleLabel() {
        addSubview(pressureTitleLabel)
        pressureTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p75)
            $0.centerX.equalToSuperview()
        }
        
        pressureTitleLabel.textAlignment = .center
        pressureTitleLabel.textColor = .white
        pressureTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        pressureTitleLabel.text = "Pressure: "
    }
    
    private func setupPressureLabel() {
        addSubview(pressureLabel)
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(pressureTitleLabel.snp.bottom).offset(Padding.p30)
            $0.centerX.equalToSuperview()
        }
        
        pressureLabel.textAlignment = .center
        pressureLabel.textColor = .white
        pressureLabel.font = UIFont.systemFont(ofSize: 20)
    }
    
    private func setupSummaryTitleLabel() {
        addSubview(summaryTitleLabel)
        summaryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(pressureLabel.snp.bottom).offset(Padding.p50)
            $0.centerX.equalToSuperview()
        }
        
        summaryTitleLabel.textAlignment = .center
        summaryTitleLabel.textColor = .white
        summaryTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        summaryTitleLabel.text = "Summary: "
    }
    
    private func setupSummaryLabel() {
        addSubview(summaryLabel)
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(summaryTitleLabel.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p20)
            $0.trailing.equalToSuperview().offset(-Padding.p20)
        }
        
        summaryLabel.textAlignment = .center
        summaryLabel.textColor = .white
        summaryLabel.font = UIFont.systemFont(ofSize: 20)
        summaryLabel.numberOfLines = 0
    }
    
    private func setupPointsOfInterestButton() {
        addSubview(pointsOfInterestButton)
        pointsOfInterestButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Padding.p40)
            $0.leading.equalToSuperview().offset(Padding.p30)
            $0.trailing.equalToSuperview().offset(-Padding.p30)
            $0.height.equalTo(Height.h50)
        }
        
        pointsOfInterestButton.setTitle("Points of Interest", for: .normal)
        pointsOfInterestButton.backgroundColor = .gray
        pointsOfInterestButton.layer.cornerRadius = 10
        pointsOfInterestButton.layer.borderColor = UIColor.white.cgColor
        pointsOfInterestButton.layer.borderWidth = 2
        pointsOfInterestButton.setTitleColor(UIColor.white, for: .normal)
        pointsOfInterestButton.addTarget(self, action: #selector(pointsOfInterestButtonTapped), for: .touchUpInside)
    }
    
    @objc private func pointsOfInterestButtonTapped() {
        delegate?.showPointsOfInterest()
    }
}
