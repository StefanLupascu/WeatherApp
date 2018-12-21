////
////  LocationsViewController.swift
////  WeatherApp
////
////  Created by Stefan on 22/06/2018.
////  Copyright © 2018 Stefan. All rights reserved.
////

import UIKit
import CoreData
//import FirebaseAuth

final class LocationsViewController: NavigationController {
    // MARK: Properties
    
    private var viewModel: LocationsViewModel
//    private var viewModel: CityViewModel
    private let cellId = "cityCellId"
    
    private let tableView = UITableView()
    private let mapViewController = MapViewController()
    private let dataManager = DataManager()
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Init
    
//    init(viewModel: CityViewModel) {
//        self.viewModel = viewModel
//
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(viewModel: LocationsViewModel) {
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
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
//        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        mapViewController.delegate = self
//        sideMenuView.delegate = self
        viewModel.delegate = self
        
        setupTableView()
        setupUI()
        setupButtons()
    }
    
    // MARK: - Private Functions
    
    @objc private func goToMap() {
        navigationController?.pushViewController(mapViewController, animated: true)
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
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delete
    
    private func delete(deleteIndex: IndexPath) {
        viewModel.removeCity(at: deleteIndex.row)
        
        tableView.beginUpdates()
        tableView.deleteRows(at: [deleteIndex], with: .automatic)
        tableView.endUpdates()
    }
    
    private func presentDetails(for city: City) {
        guard Reachability.isConnectedToNetwork() else {
            presentAlert(message: "No internet connection!")
            return
        }
        showActivityIndicator()
        
        dataManager.weatherDetailsFor(latitude: city.latitude, longitude: city.longitude) { [weak self](details, error) in
            guard let strongSelf = self, let details = details else {
                return
            }
            let updatedCity = strongSelf.update(city: city, with: details)
//            let detailsViewController = DetailsViewController(city: updatedCity)
//            detailsViewController.delegate = self
            let detailsViewController = InformationViewController(city: updatedCity)
            detailsViewController.delegate = self
            strongSelf.navigationController?.pushViewController(detailsViewController, animated: true)
            
            self?.activityIndicator.stopAnimating()
        }
    }
    
    @discardableResult private func update(city: City, with details: Detail) -> City {
        guard let index = viewModel.cities.index(of: city) else {
            fatalError("Sanity check")
        }
        
        viewModel.cities[index].details = details
        
        return viewModel.cities[index]
    }

    private func setupButtons() {
        let button = UIBarButtonItem(image: UIImage(named: "map"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(goToMap))
        navigationItem.rightBarButtonItem = button
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.register(CityCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
//    private func setupGestures() {
//        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissSideMenu))
//        leftSwipe.direction = .left
//        sideMenuView.addGestureRecognizer(leftSwipe)
//
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSideMenu))
//        rightView.addGestureRecognizer(tap)
//    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
//        setupGestures()
//        rightView.backgroundColor = UIColor(white: 0, alpha: 0)
        
        view.addSubview(tableView)
//        navigationController?.view.addSubview(rightView)
//        navigationController?.view.addSubview(sideMenuView)
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Padding.f20)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
//        rightView.snp.makeConstraints {
//            $0.top.leading.trailing.bottom.equalToSuperview()
//        }
//
//        rightView.isUserInteractionEnabled = false
//
//        sideMenuView.snp.makeConstraints {
//            $0.top.bottom.equalToSuperview()
//            $0.leading.equalToSuperview().offset(-Padding.f285)
//            $0.width.equalTo(view.frame.width * 0.75)
//        }
    }
}

// MARK: - UITableViewDataSource

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CityCell
        cityCell.nameLabel.text = viewModel.cities[indexPath.row].name

        return cityCell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { _,_ in
            guard Reachability.isConnectedToNetwork() else {
                self.presentAlert(message: "Cannot delete while not connected to internet!")
                return
            }
            self.delete(deleteIndex: indexPath)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        return [delete]
    }
}

// MARK: - MapViewDelegate

extension LocationsViewController: MapViewDelegate {
    func didRecieveNewWeatherData(city: City) {
        viewModel.addCity(city)
        
        tableView.reloadData()
//        dismissSideMenu()
    }
}

// MARK: - DetailsViewDelegate

extension LocationsViewController: DetailsViewDelegate {
    func didUpdateNote(city: City) {
        viewModel.updateCity(city: city)
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

// MARK: - SideMenuViewDelegate

//extension LocationsViewController: SideMenuViewDelegate {
//    func seeTutorial() {
//        let tutorialVC = DemoPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
//        present(tutorialVC, animated: true)
//    }
//
//    func openMap() {
//        goToMap()
//    }
//
//    func goToVacationPlanning() {
//        let vacationViewController = VacationViewController()
//        present(vacationViewController, animated: true)
//    }
//
//    func logout() {
//        do {
//            try Auth.auth().signOut()
//        } catch let logoutError {
//            print(logoutError)
//        }
//
//        let loginViewController = LoginViewController()
//        present(loginViewController, animated: true)
//    }
//}

// MARK: - CitiesDelegate

extension LocationsViewController: CitiesDelegate {
    func cityListChanged() {
        tableView.reloadData()
    }
    
    func didNotAdd() {
        presentAlert(message: "Cannot add the same city twice!")
    }
}

// MARK: - LocationsDelegate

extension LocationsViewController: LocationsDelegate {
    func didAddCity(ok: Bool) {
        if ok {
            tableView.reloadData()
        } else {
            presentAlert(message: "Cannot add the same city twice!")
        }
    }
}
