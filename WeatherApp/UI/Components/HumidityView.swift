//
//  HumidityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

enum Animation {
    static let strokeEnd = "strokeEnd"

    case tracking
    case loading
    
    var type: String {
        switch self {
        case .loading:
            return "loading"
        case .tracking:
            return "tracking"
        }
    }
}

final class HumidityView: UICollectionViewCell {
    // MARK: - Properties
    
    var humidity: Double = 0 {
        didSet {
            animate()
            percentageLabel.text = "\(Int(100 * humidity))%"
        }
    }
    
    private let humidityLabel = UILabel()
    private let percentageLabel = UILabel()
    private var loadingCircle = CAShapeLayer()
    private var trackingCircle = CAShapeLayer()
    
    // MARK: - Base Class Overrides
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func draw() {
        let loadingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 3 - Padding.p20, startAngle: -.pi / 2, endAngle: CGFloat(humidity) * 2 * .pi - .pi / 2, clockwise: true)
        let trackingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 3 - Padding.p20, startAngle: CGFloat(humidity) * 2 * .pi - .pi / 2, endAngle: 2 * .pi - .pi / 2, clockwise: true)
        
        loadingCircle = createCircle(color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
        trackingCircle = createCircle(color: .gray)
        
        loadingCircle.path = loadingPath.cgPath
        trackingCircle.path = trackingPath.cgPath
    }
    
    private func createCircle(color: UIColor) -> CAShapeLayer {
        let circle = CAShapeLayer()
        circle.strokeColor = color.cgColor
        circle.fillColor = UIColor.clear.cgColor
        circle.lineWidth = 60
        
        return circle
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        draw()
        setupGesture()
        setupHumidityLabel()
        setupPercentegeLabel()
        
        layer.addSublayer(trackingCircle)
        layer.addSublayer(loadingCircle)
        
        animate()
    }
    
    private func setupHumidityLabel() {
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont.boldSystemFont(ofSize: 24)
        humidityLabel.text = "Humidity"
        
        addSubview(humidityLabel)
        humidityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p75)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupPercentegeLabel() {
        percentageLabel.textAlignment = .center
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        addSubview(percentageLabel)
        percentageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(animate))
        addGestureRecognizer(tap)
    }
    
    private func animateCircle(_ circle: CAShapeLayer, for key: Animation) {
        circle.strokeEnd = 0
        
        let animation = CABasicAnimation(keyPath: Animation.strokeEnd)
        animation.toValue = 1
        
        switch key {
        case .loading:
            animation.duration = CFTimeInterval(humidity)
        case .tracking:
            animation.duration = CFTimeInterval(1 - humidity)
            animation.beginTime = CACurrentMediaTime() + CFTimeInterval(1 - humidity)
        }
        
        animation.duration = CFTimeInterval(1 - humidity)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        circle.add(animation, forKey: key.type)
    }
    
    @objc private func animate() {
        animateCircle(loadingCircle, for: .loading)
        animateCircle(trackingCircle, for: .tracking)
    }
}
