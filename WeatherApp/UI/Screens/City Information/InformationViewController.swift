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
    
    var delegate: DetailsViewDelegate?
    
    private var city: City
    
//    private let temperatureCellId = "temperatureCellId"
//    private let humidityCellId = "humidityCellId"
//    private let summaryCellId = "summaryCellId"
//    private let notesCellId = "notesCellId"
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 15
        collectionView.bounces = false
        
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
    
    // MARK: - Base Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupLabel()
        setupGesture()
        setupUI()
    }
    
    // MARK: - Keyboard Handling
    
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer!) {
        view.endEditing(true)
    }
    
    // MARK: - Private functions
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Information"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
    }
    
    private func setupCollectionView() {
        collectionView.register(TemperatureView.self, forCellWithReuseIdentifier: CellId.temperatureCellId)
        collectionView.register(HumidityView.self, forCellWithReuseIdentifier: CellId.humidityCellId)
        collectionView.register(NotesView.self, forCellWithReuseIdentifier: CellId.notesCellId)
        collectionView.register(SummaryView.self, forCellWithReuseIdentifier: CellId.summaryCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLabel() {
        titleLabel.text = city.name
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .white
        titleLabel.shadowColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = Height.h5
    }
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func setupUI() {
        containerView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        view.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(Height.h200)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.p30)
            $0.leading.equalToSuperview().offset(Padding.p10)
            $0.trailing.equalToSuperview().offset(-Padding.p10)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Padding.p10)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.temperatureCellId, for: indexPath) as! TemperatureView
            guard let temperature = city.details?.temperature else {
                return UICollectionViewCell()
            }
            let temperatureInCelsius = (temperature - 32) * 5 / 9
            cell.temperature = temperatureInCelsius
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.humidityCellId, for: indexPath) as! HumidityView
            guard let humidity = city.details?.humidity else {
                return UICollectionViewCell()
            }
            cell.humidity = humidity
            
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.summaryCellId, for: indexPath) as! SummaryView
            guard let pressure = city.details?.pressure,
                    let summary = city.details?.summary else {
                return UICollectionViewCell()
            }

            cell.pressure = pressure
            cell.summary = summary
            cell.delegate = self
            
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellId.notesCellId, for: indexPath) as! NotesView
            cell.notesTextView.text = city.note
            cell.notesTextView.delegate = self
            
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

// MARK: - UITextViewDelegate

extension InformationViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        city.note = textView.text
        delegate?.didUpdateNote(for: city)
    }
}

// MARK: - PointsOfInterestViewDelegate

extension InformationViewController: PointsOfInterestViewDelegate {
    func showPointsOfInterest() {        
        let viewModel = VenuesViewModel(city: city)
        let venuesViewController = VenuesViewController(viewModel: viewModel)
        navigationController?.pushViewController(venuesViewController, animated: true)
    }
}
