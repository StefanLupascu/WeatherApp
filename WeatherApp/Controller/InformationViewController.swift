//
//  InformationViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 06/10/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class InformationViewController: UIViewController {
    // MARK: - Properties
    
    private let temperatureCellId = "temperatureCellId"
    private let humidityCellId = "humidityCellId"
    private let cellId = "cellId"
    private let city: City
    private var details = [UICollectionViewCell]()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let temperatureView = TemperatureView()
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 15
//        collectionView.contentInset = UIEdgeInsets(top: Padding.f20, left: Padding.f20, bottom: Padding.f20, right: Padding.f20)
        
        return collectionView
    }()
    
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
        
        navigationItem.title = "Information"
        
        setupCollectionView()
        setupViews()
        setupDetails()
        setupLabel()
        setupUI()
    }
    
    // MARK: - Private functions
    
    private func setupCollectionView() {
        collectionView.register(TemperatureView.self, forCellWithReuseIdentifier: temperatureCellId)
        collectionView.register(HumidityView.self, forCellWithReuseIdentifier: humidityCellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupDetails() {
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        view1.backgroundColor = .red
        view2.backgroundColor = .green
        view3.backgroundColor = .blue
        
        details.append(temperatureView)
//        details.append(view1)
//        details.append(view2)
//        details.append(view3)
    }
    
    private func setupViews() {
        temperatureView.layer.cornerRadius = 20
        guard let temperature = city.details?.temperature else {
            return
        }
        let temperatureInCelsius = (temperature - 32) * 5 / 9
        temperatureView.temperature = temperatureInCelsius
    }
    
    private func setupLabel() {
        titleLabel.text = city.name
        titleLabel.backgroundColor = .clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 5
    }
    
    private func setupUI() {
        containerView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        view.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f75)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f30)
            $0.leading.equalToSuperview().offset(Padding.f10)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.f10)
        }
    }
}

// MARK: - UICollectionViewDataSource

extension InformationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: temperatureCellId, for: indexPath) as! TemperatureView
            guard let temperature = city.details?.temperature else {
                return UICollectionViewCell()
            }
            let temperatureInCelsius = (temperature - 32) * 5 / 9
            cell.temperature = temperatureInCelsius
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: humidityCellId, for: indexPath) as! HumidityView
            guard let humidity = city.details?.humidity else {
                return UICollectionViewCell()
            }
            cell.humidity = humidity
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .blue
            
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = .purple
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension InformationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
