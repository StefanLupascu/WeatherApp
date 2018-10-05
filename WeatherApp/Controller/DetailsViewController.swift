//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: class {
    func didUpdateNote(city: City)
}

final class DetailsViewController: UIViewController {
    // MARK: - Properties
    
    var city: City
    var cityView = CityView()
    weak var delegate: DetailsViewDelegate?
    
    // MARK: - Init
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = cityView
        navigationItem.title = "Information"
        setupGesture()
        setupCity()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Private Functions
    
    private func setupCity() {
        guard let temperature = city.details?.temperature,
              let humidity = city.details?.humidity,
              let pressure = city.details?.pressure,
              let summary = city.details?.summary else {
                return
        }
        
        let temperatureInCelsius = Int((temperature - 32) * 5 / 9)
        
        cityView.nameLabel.text = city.name
        cityView.temperatureLabel.text = "Temperature of: \(temperatureInCelsius)ºC"
        cityView.humidityLabel.text = "Humidity: \(Int(100 * humidity))%"
        cityView.pressureLabel.text = "Pressure: \(pressure)"
        cityView.summaryLabel.text = "Summary: \(summary)"
        cityView.notesTextView.text = city.note
        cityView.notesTextView.delegate = self
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        cityView.addGestureRecognizer(gesture)
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

// MARK: - UITextViewDelegate

extension DetailsViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        city.note = textView.text
        delegate?.didUpdateNote(city: city)
    }
}
