//
//  CityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class CityView: UIView {
    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let cityImageView = UIImageView()
    
    let nameLabel = UILabel()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    let pressureLabel = UILabel()
    let summaryLabel = UILabel()
    let notesTextView = UITextView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupImage()
        setupTextview()
        setupLabels()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupImage() {
        let image = UIImage(named: "city")
        cityImageView.image = image
    }
    
    private func setupTextview() {
        notesTextView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        notesTextView.adjustsFontForContentSizeCategory = true
        notesTextView.isSelectable = true
        notesTextView.isEditable = true
        notesTextView.layer.cornerRadius = Padding.p10
        notesTextView.font = UIFont.systemFont(ofSize: Padding.p20)
    }
    
    private func setupLabels() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: Padding.p25)
        temperatureLabel.font = UIFont.systemFont(ofSize: Padding.p20)
        humidityLabel.font = UIFont.systemFont(ofSize: Padding.p20)
        pressureLabel.font = UIFont.systemFont(ofSize: Padding.p20)
        summaryLabel.font = UIFont.systemFont(ofSize: Padding.p20)
    }
    
    private func setupViews() {
        let screensize = UIScreen.main.bounds
        scrollView.contentSize = CGSize(width: screensize.width, height: screensize.height)
        backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        addSubview(scrollView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(temperatureLabel)
        scrollView.addSubview(humidityLabel)
        scrollView.addSubview(pressureLabel)
        scrollView.addSubview(summaryLabel)
        scrollView.addSubview(notesTextView)
        scrollView.addSubview(cityImageView)

        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(Padding.p20)
            $0.leading.trailing.equalToSuperview().offset(Padding.p20)
        }
        
        //temperatureLabel setup
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
        
        //city image setup
        cityImageView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.top).offset(Padding.p20)
            $0.leading.equalTo(temperatureLabel.snp.trailing).offset(Padding.p20)
        }
        
        //humidityLabel setup
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
        
        //pressureLabel setup
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(humidityLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
        
        //summaryLabel setup
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(pressureLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
        }
        
        //notesTextView setup
        notesTextView.snp.makeConstraints {
            $0.top.equalTo(summaryLabel.snp.bottom).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p20)
            $0.width.equalTo(Height.h335)
            $0.height.equalTo(Height.h300)
        }
    }
}
