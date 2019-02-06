//
//  PredictionsViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 22/01/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class PredictionsViewController: NavigationController {
    // MARK: - Properties
    
    private let viewModel: LocationsViewModel
    
    private let cellId = "cellId"
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    // MARK: - Init
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Predictions"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PredictionsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Padding.p20)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.p20)
        }
    }
    
    private func preparePrediction(for index: Int) {
        let city = viewModel.cities[index]
        let predictionViewController = PredictionViewController(city: city)
        navigationController?.pushViewController(predictionViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension PredictionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        preparePrediction(for: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource

extension PredictionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PredictionsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = viewModel.cities[indexPath.item].name
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PredictionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - Padding.p40, height: Height.h100)
    }
}

// MARK: - LocationsDelegate

extension PredictionsViewController: LocationsDelegate {
    func didAddCity(ok: Bool) {
        print("nothing")
    }
    
    func didFetchCities() {
        collectionView.reloadData()
    }
    
    func didNotGetCities() {
        print("nothing")
    }
}
