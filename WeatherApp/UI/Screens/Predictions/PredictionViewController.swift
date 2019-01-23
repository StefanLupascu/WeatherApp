//
//  PredictionViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 22/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class PredictionViewController: UIViewController {
    // MARK: - Properties
    
    private var temperature = 0 {
        didSet {
            forecastLabel.text = "Temperature:\n \(String(describing: temperature)) ºC"
            forecastLabel.isHidden = false
        }
    }
    
    private let city: City
    private let titleLabel = UILabel()
    private let picker = UIDatePicker()
    private let predictButton = UIButton()
    private let forecastLabel = UILabel()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Init
    
    init(city: City) {
        self.city = city
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupNavigationBar()
        setupTitleLabel()
        setupDatePicker()
        setupPredictButton()
        setupForecastLabel()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Prediction"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.shadowColor = .black
        titleLabel.text = city.name
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.f30)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupDatePicker() {
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKey: "textColor")
        
        view.addSubview(picker)
        picker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f30)
            $0.leading.equalToSuperview().offset(Padding.f30)
            $0.trailing.equalToSuperview().offset(-Padding.f30)
        }
    }
    
    private func setupPredictButton() {
        predictButton.backgroundColor = .gray
        predictButton.layer.cornerRadius = 15
        predictButton.setTitleShadowColor(.black, for: .normal)
        predictButton.layer.borderWidth = 2
        predictButton.layer.borderColor = UIColor.white.cgColor
        predictButton.setTitle("Predict Temperature", for: .normal)
        predictButton.addTarget(self, action: #selector(predictButtonTapped), for: .touchUpInside)
        
        view.addSubview(predictButton)
        predictButton.snp.makeConstraints {
            $0.top.equalTo(picker.snp.bottom).offset(Padding.f30)
            $0.leading.equalToSuperview().offset(Padding.f30)
            $0.trailing.equalToSuperview().offset(-Padding.f30)
            $0.height.equalTo(Height.h70)
        }
    }
    
    private func setupForecastLabel() {
        forecastLabel.textAlignment = .center
        forecastLabel.textColor = .white
        forecastLabel.shadowColor = .black
        forecastLabel.font = UIFont.boldSystemFont(ofSize: 26)
        forecastLabel.numberOfLines = 0
        forecastLabel.text = "Temperature"
        forecastLabel.isHidden = true
        
        view.addSubview(forecastLabel)
        forecastLabel.snp.makeConstraints {
            $0.top.equalTo(predictButton.snp.bottom).offset(Padding.f90)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func predictButtonTapped() {
        temperature = 20
        print("forecast")
    }
}
