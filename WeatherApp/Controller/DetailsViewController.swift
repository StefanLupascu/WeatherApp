//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties and Initialization
    
    var city: City
    var cityView = CityView()
    
    init(city: City) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = cityView
        navigationItem.title = "Information"
        setupGesture()
        
//        var name = city.name.split(separator: "/")
        self.cityView.nameLabel.text = city.name
        self.cityView.temperatureLabel.text = "Temperature of: " + String((city.details?.temperature)!)
        self.cityView.humidityLabel.text = "Humidity: " + String((city.details?.humidity)!)
        self.cityView.pressureLabel.text = "Pressure: " + String((city.details?.pressure)!)
        self.cityView.summaryLabel.text = "Summary: " + (city.details?.summary)!
        self.cityView.notesTextView.text = city.note
        self.cityView.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        self.cityView.addGestureRecognizer(gesture)
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }

    @objc func dismissKeyboard(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
    
}
