//
//  VacationViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 12/12/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class VacationsViewController: NavigationController {
    // MARK: Properties
    
    private let viewModel: VacationsViewModel
    
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
    
    init(viewModel: VacationsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Vacations"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupButton()
        setupCollectionView()
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VacationsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(Padding.f20)
            $0.bottom.trailing.equalToSuperview().offset(-Padding.f20)
        }
    }
    
    private func presentVacation(at index: Int) {
        // TODO: - Implement Vacation Details Screen
        
    }
    
    @objc private func addButtonTapped() {
        print("add")
    }
}

// MARK: - UICollectionViewDelegate

extension VacationsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentVacation(at: indexPath.item)
    }
}

// MARK: - UICollectionViewDataSource

extension VacationsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.vacations.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? VacationsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VacationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: Height.h100)
    }
}
