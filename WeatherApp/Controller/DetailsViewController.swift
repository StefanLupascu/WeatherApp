//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

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
    
    // MARK: - ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = cityView
        navigationItem.title = "Information"
        setupGesture()
        
        cityView.nameLabel.text = city.name
        cityView.temperatureLabel.text = "Temperature of: " + String((city.details?.temperature)!)
        cityView.humidityLabel.text = "Humidity: " + String((city.details?.humidity)!)
        cityView.pressureLabel.text = "Pressure: " + String((city.details?.pressure)!)
        cityView.summaryLabel.text = "Summary: " + (city.details?.summary)!
        cityView.notesTextView.text = city.note
        cityView.notesTextView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: .UIKeyboardWillShow, object: nil)
    }
    
    // MARK: - Private Functions
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        cityView.addGestureRecognizer(gesture)
    }
    
    // MARK: - Keyboard Handling
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, view.frame.origin.y == 0 else {
            return
        }
        
        view.frame.origin.y -= keyboardSize.height
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
