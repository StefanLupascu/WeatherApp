//
//  HumidityView.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 17/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

struct Animation {
    static let strokeEnd = "strokeEnd"
    static let tracking = "tracking"
    static let loading = "loading"
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

        draw()
        setupGesture()
        setupLabels()
        setupUI()
        animate()
    }
    
    // MARK: - Private Functions
    
    private func setupLabels() {
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .white
        humidityLabel.font = UIFont.boldSystemFont(ofSize: 24)
        humidityLabel.text = "Humidity"
        
        percentageLabel.textAlignment = .center
        percentageLabel.textColor = .white
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(animate))
        addGestureRecognizer(tap)
    }
    
    private func draw() {
        let loadingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 3 - Padding.f20, startAngle: -.pi / 2, endAngle: CGFloat(humidity) * 2 * .pi - .pi / 2, clockwise: true)
        let trackingPath = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: bounds.width / 3 - Padding.f20, startAngle: CGFloat(humidity) * 2 * .pi - .pi / 2, endAngle: 2 * .pi - .pi / 2, clockwise: true)
        
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
    
    @objc private func animate() {
        animateLoadingCircle()
        animateTrackingCircle()
    }
    
    private func animateLoadingCircle() {
        loadingCircle.strokeEnd = 0
        let basicAnimation = CABasicAnimation(keyPath: Animation.strokeEnd)
        basicAnimation.toValue = 1
        basicAnimation.duration = CFTimeInterval(humidity)
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        loadingCircle.add(basicAnimation, forKey: Animation.loading)
    }
    
    private func animateTrackingCircle() {
        trackingCircle.strokeEnd = 0
        let trackingAnimation = CABasicAnimation(keyPath: Animation.strokeEnd)
        trackingAnimation.toValue = 1
        trackingAnimation.duration = CFTimeInterval(1 - humidity)
        trackingAnimation.fillMode = CAMediaTimingFillMode.forwards
        trackingAnimation.isRemovedOnCompletion = false
        trackingAnimation.beginTime = CACurrentMediaTime() + CFTimeInterval(humidity) + 0.05
        
        trackingCircle.add(trackingAnimation, forKey: Animation.tracking)
    }
    
    private func setupUI() {
        backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        addSubview(humidityLabel)
        addSubview(percentageLabel)

        layer.addSublayer(trackingCircle)
        layer.addSublayer(loadingCircle)
        
        humidityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(75)
            $0.centerX.equalToSuperview()
        }
        
        percentageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
