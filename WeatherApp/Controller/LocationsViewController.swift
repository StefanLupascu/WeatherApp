////
////  LocationsViewController.swift
////  WeatherApp
////
////  Created by Stefan on 22/06/2018.
////  Copyright © 2018 Stefan. All rights reserved.
////

import UIKit
import CoreData

final class LocationsViewController: UIViewController {
    // MARK: Properties
    
    private var cities = [City]()
    private let cellId = "cellId"
    
    private let sideMenuView = SideMenuView()
    private let rightView = UIView()
    private let tableView = UITableView()
    private let mapViewController = MapViewController()
    private let dataManager = DataManager()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Base class overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cities"
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        mapViewController.delegate = self
        sideMenuView.delegate = self
        
        setupTableView()
        setupUI()
        setupButtons()
        getData()
    }
    
    // MARK: - Private Functions
    
    @objc private func goToMap() {
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    private func getData() {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let cities = try PersistenceService.context.fetch(fetchRequest)
            self.cities = cities
        } catch {
            print("Error \(error)")
        }
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
        PersistenceService.context.delete(cities[deleteIndex.row])
        cities.remove(at: deleteIndex.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [deleteIndex], with: .automatic)
        tableView.endUpdates()
        
        PersistenceService.saveContext()
    }
    
    private func presentDetails(for city: City) {
        showActivityIndicator()
        
        dataManager.weatherDetailsFor(latitude: city.latitude, longitude: city.longitude) { [weak self](details, error) in
            guard let strongSelf = self, let details = details else {
                return
            }
            let updatedCity = strongSelf.update(city: city, with: details)
            let detailsViewController = DetailsViewController(city: updatedCity)
            detailsViewController.delegate = self
            strongSelf.navigationController?.pushViewController(detailsViewController, animated: true)
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @discardableResult private func update(city: City, with details: Detail) -> City {
        guard let index = cities.index(of: city) else {
            fatalError("Sanity check")
        }
        
        cities[index].details = details
        
        return cities[index]
    }
    
    @objc private func menuButtonTapped() {
        sideMenuView.snp.updateConstraints {
            $0.leading.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.rightView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        }
        rightView.isUserInteractionEnabled = true
    }

    private func setupButtons() {
        let button = UIBarButtonItem(image: UIImage(named: "map"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToMap))
        navigationItem.rightBarButtonItem = button
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = menuButton
    }
    
    private func updateCity(city: City) {
        for index in 0..<cities.count {
            if cities[index].latitude == city.latitude && cities[index].longitude == city.longitude {
                cities[index].note = city.note
            }
        }
    }
    
    private func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func dismissSideMenu() {
        sideMenuView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(-Padding.f250)
        }
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
            self.rightView.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        rightView.isUserInteractionEnabled = false
    }
    
    private func setupGestures() {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        leftSwipe.direction = .left
        sideMenuView.addGestureRecognizer(leftSwipe)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
        rightView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        setupGestures()
        rightView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        view.addSubview(tableView)
        view.addSubview(rightView)
        view.addSubview(sideMenuView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        rightView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        sideMenuView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(Padding.f40)
            $0.leading.equalToSuperview().offset(-Padding.f250)
            $0.width.equalTo(Height.h250)
        }
    }
}

// MARK: - UITableViewDataSource

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CityCell
        cityCell.nameLabel.text = cities[indexPath.row].name
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delete(deleteIndex: indexPath)
        }
    }
}

// MARK: - UITableViewDelegate

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetails(for: cities[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MapViewDelegate

extension LocationsViewController: MapViewDelegate {
    func didRecieveNewWeatherData(city: City) {
        cities.append(city)

        tableView.reloadData()
        dismissSideMenu()
        PersistenceService.saveContext()
    }
}

// MARK: - DetailsViewDelegate

extension LocationsViewController: DetailsViewDelegate {
    func didUpdateNote(city: City) {
        updateCity(city: city)
        PersistenceService.saveContext()
    }
}

// MARK: - SideMenuViewDelegate

extension LocationsViewController: SideMenuViewDelegate {
    func seeTutorial() {
        let tutorialVC = DemoPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        present(tutorialVC, animated: true)
    }
    
    func openMap() {
        goToMap()
    }
    
    func logout() {
        let loginViewController = LoginViewController()
        present(loginViewController, animated: true)
    }
}
