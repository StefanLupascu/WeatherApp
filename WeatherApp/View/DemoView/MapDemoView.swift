//
//  MapDemoView.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class MapDemoView: UIView {
    // MARK: - Properties
    
    var infoView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: Padding.f20)
        textView.backgroundColor = .clear
        return textView
    }()
    
    var screenImage: UIImageView = {
        let image = UIImage(named: "screen4")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: Padding.f75, y: Padding.f190, width: Padding.f230, height: Padding.f400)
        return imageView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        addSubview(infoView)
        addSubview(screenImage)
        
        infoView.topAnchor.constraint(equalTo: topAnchor, constant: Padding.f70).isActive = true
        infoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.f20).isActive = true
        infoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Padding.f20).isActive = true
        infoView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.f400).isActive = true
        
        infoView.text = "Use the map to navigate and tap anywhere on it to place a pin. After placing the pin, tap on the 'Done' button to get the location."
    }
}
