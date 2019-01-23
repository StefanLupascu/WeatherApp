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
    private let summaryCellId = "summaryCellId"
    private let notesCellId = "notesCellId"
    private let city: City
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let temperatureView = TemperatureView()
    
    weak var delegate: DetailsViewDelegate?
    
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
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupCollectionView()
        setupViews()
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
        collectionView.register(TemperatureView.self, forCellWithReuseIdentifier: temperatureCellId)
        collectionView.register(HumidityView.self, forCellWithReuseIdentifier: humidityCellId)
        collectionView.register(NotesView.self, forCellWithReuseIdentifier: notesCellId)
        collectionView.register(SummaryView.self, forCellWithReuseIdentifier: summaryCellId)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        titleLabel.textColor = .white
        titleLabel.shadowColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        titleLabel.textAlignment = .center
        titleLabel.layer.cornerRadius = 5
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.f20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Padding.f30)
            $0.leading.equalToSuperview().offset(Padding.f10)
            $0.trailing.equalToSuperview().offset(-Padding.f10)
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Padding.f10)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: summaryCellId, for: indexPath) as! SummaryView
            guard let pressure = city.details?.pressure,
                    let summary = city.details?.summary else {
                return UICollectionViewCell()
            }

            cell.pressure = pressure
            cell.summary = summary
            cell.delegate = self
            
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: notesCellId, for: indexPath) as! NotesView
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
        delegate?.didUpdateNote(city: city)
    }
}

// MARK: - PointsOfInterestViewDelegate

extension InformationViewController: PointsOfInterestViewDelegate {
    func showPointsOfInterest() {
        guard let cityName = city.name else {
            return
        }
        
        let viewModel = VenuesViewModel(cityName: cityName)
        let venuesViewController = VenuesViewController(viewModel: viewModel)
        navigationController?.pushViewController(venuesViewController, animated: true)
    }
}
