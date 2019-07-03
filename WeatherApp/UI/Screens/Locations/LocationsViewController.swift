//
//  LocationsViewController.swift
//  WeatherApp
//
//  Created by Stefan on 22/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit
import SnapKit

final class LocationsViewController: NavigationController {
    // MARK: Properties
    
    private var viewModel: LocationsViewModel
    
    private let tableView = UITableView()
    private let mapViewController = MapViewController()
    private let dataManager = DataManager()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init
    
    init(viewModel: LocationsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        mapViewController.delegate = self
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Base Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        setupNavigationBar()
        showActivityIndicator()
        setupButton()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        let label = UILabel()
        label.text = "Cities"
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        
        navigationItem.titleView = label
    }
    
    private func showActivityIndicator() {
        activityIndicator.frame = view.frame
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func delete(deleteIndex: IndexPath) {
        viewModel.removeCity(at: deleteIndex.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [deleteIndex], with: .automatic)
        tableView.endUpdates()
    }
    
    private func presentDetails(for city: City) {
        showActivityIndicator()
        
        dataManager.weatherDetailsFor(latitude: city.latitude, longitude: city.longitude) { [weak self] (details, error) in
            guard let self = self, let details = details else {
                return
            }
            let updatedCity = self.update(city: city, with: details)
            
            let viewModel = InformationViewModel(city: updatedCity)
            let informationViewController = InformationViewController(viewModel: viewModel)
            informationViewController.delegate = self
            self.navigationController?.pushViewController(informationViewController, animated: true)
            
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func update(city: City, with details: Detail) -> City {
        guard let index = viewModel.cities.firstIndex(of: city) else {
            fatalError("City not found!")
        }
        
        viewModel.cities[index].details = details
        
        return viewModel.cities[index]
    }

    private func setupButton() {
        let button = UIBarButtonItem(image: UIImage(named: "map"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToMap))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.p20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.backgroundColor = .clear
        tableView.register(CityCell.self, forCellReuseIdentifier: CellId.cityCellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func goToMap() {
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: CellId.cityCellId, for: indexPath) as! CityCell
        
        cityCell.nameLabel.text = viewModel.cities[indexPath.row].name

        return cityCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
            self.delete(deleteIndex: indexPath)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        return [delete]
    }
}

// MARK: - MapViewDelegate

extension LocationsViewController: MapViewDelegate {
    func didRecieveNewWeatherData(for city: City) {
        viewModel.add(city)
        tableView.reloadData()
    }
}

// MARK: - DetailsViewDelegate

extension LocationsViewController: InformationViewDelegate {
    func didUpdateNote(for city: City) {
        viewModel.update(city)
    }
}

// MARK: - UITableViewDelegate

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetails(for: viewModel.cities[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Height.h70
    }
}

// MARK: - LocationsDelegate

extension LocationsViewController: LocationsDelegate {
    func didAddCity() {
        tableView.reloadData()
    }
    
    func failedToAddCity() {
        presentAlert(message: "Cannot add the same city twice!")
    }
    
    func didFetchCities() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func didNotGetCities() {
        activityIndicator.stopAnimating()
    }
}
