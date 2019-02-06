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
    
    private var temperatures = [Int]() {
        didSet {
            if temperatures.count == 5 {
                setPrediction()
            }
        }
    }
    private var temperature = 0 {
        didSet {
            forecastLabel.text = "Temperature:\n \(String(describing: temperature)) ºC"
            forecastLabel.isHidden = false
        }
    }
    
    private let manager = DataManager()
    private let city: City
    private let titleLabel = UILabel()
    private let picker = UIDatePicker()
    private let predictButton = UIButton()
    private let forecastLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
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
    
    private func setPrediction() {
        var temp = 0
        
        temperatures.forEach {
            temp = temp + $0
        }
        
        activityIndicator.stopAnimating()
        temperature = temp / 5
        temperatures.removeAll()
    }
    
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p30)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupDatePicker() {
        picker.datePickerMode = .date
        picker.setValue(UIColor.white, forKey: "textColor")
        
        view.addSubview(picker)
        picker.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p30)
            $0.trailing.equalToSuperview().offset(-Padding.p30)
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
            $0.top.equalTo(picker.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p30)
            $0.trailing.equalToSuperview().offset(-Padding.p30)
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
            $0.top.equalTo(predictButton.snp.bottom).offset(Padding.p90)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func showActivityIndicator() {
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func predictButtonTapped() {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentYear = calendar.component(.year, from: date as Date)
        let year = calendar.component(.year, from: picker.date)
        let month = calendar.component(.month, from: picker.date)
        let day = calendar.component(.day, from: picker.date)
        let pickedDate = calendar.date(from: DateComponents(year: year, month: month, day: day))
        
        guard pickedDate! > date as Date else {
            presentAlert(message: "You must choose a future date!")
            return
        }
        
        showActivityIndicator()
        
        var years = [currentYear - 4, currentYear - 3, currentYear - 2, currentYear - 1]
        
        if year > currentYear {
            years.append(currentYear)
        } else {
            years.append(currentYear - 5)
        }
        
        years.forEach { year in
            let date = calendar.date(from: DateComponents(year: year, month: month, day: day))
            guard let timestamp = date?.timeIntervalSince1970 else {
                return
            }
            
            manager.getTemperature(for: city, timestamp: timestamp) { (data, error) in
                guard let data = data else {
                    return
                }
                
                self.format(data: data)
            }
        }
    }
    
    private func format(data: Data) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as?  [String: AnyObject] else {
            return
        }
        
        guard let currently = json?["currently"] as? [String: AnyObject],
                let temperature = currently["temperature"] as? Double else {
            return
        }
        
        let temperatureInCelsius = (temperature - 32) * 5 / 9
        temperatures.append(Int(temperatureInCelsius))
    }
}
