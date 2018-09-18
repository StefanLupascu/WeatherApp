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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Padding.f25)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(Padding.f20)
        
        return label
    }()
    
    let humidityLabel: UILabel = {
       let label = UILabel()
        label.font = label.font.withSize(Padding.f20)
        
        return label
    }()
    
    let pressureLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(Padding.f20)
        
        return label
    }()
    
    let summaryLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(Padding.f20)
        
        return label
    }()
    
    let notesTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        textView.adjustsFontForContentSizeCategory = true
        textView.isSelectable = true
        textView.isEditable = true
        textView.layer.cornerRadius = Padding.f10
        textView.font = UIFont.systemFont(ofSize: Padding.f20)
        
        return textView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
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

        scrollView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(Padding.f20)
            $0.leading.trailing.equalToSuperview().offset(Padding.f20)
        }
        
        //temperatureLabel setup
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(Padding.f20)
            $0.leading.equalToSuperview().offset(Padding.f20)
        }
        
        //humidityLabel setup
        humidityLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(Padding.f20)
            $0.leading.equalToSuperview().offset(Padding.f20)
        }
        
        //pressureLabel setup
        pressureLabel.snp.makeConstraints {
            $0.top.equalTo(humidityLabel.snp.bottom).offset(Padding.f20)
            $0.leading.equalToSuperview().offset(Padding.f20)
        }
        
        //summaryLabel setup
        summaryLabel.snp.makeConstraints {
            $0.top.equalTo(pressureLabel.snp.bottom).offset(Padding.f20)
            $0.leading.equalToSuperview().offset(Padding.f20)
        }
        
        //notesTextView setup
        notesTextView.snp.makeConstraints {
            $0.top.equalTo(summaryLabel.snp.bottom).offset(Padding.f20)
            $0.leading.equalToSuperview().offset(Padding.f20)
            $0.width.equalTo(335)
            $0.height.equalTo(300)
        }
    }
}
