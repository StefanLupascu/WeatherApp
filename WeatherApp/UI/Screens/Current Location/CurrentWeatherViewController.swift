//
//  CurrentWeatherViewController.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 09/02/2019.
//  Copyright © 2019 Stefan. All rights reserved.
//

import UIKit
import SnapKit
import SceneKit
import ARKit
import CoreLocation

final class CurrentWeatherViewController: UIViewController, ARSCNViewDelegate {
    // MARK: - Properties
    
    private var currentCity: City? {
        didSet {
            getWeather()
        }
    }
    
    private var temperature: Int = 0 {
        didSet {
            setLabelText()
        }
    }
    
    private var isLabelDisplayed = false
    private var planeGeometry: SCNPlane!
    private var anchors = [ARAnchor]()
    
    private var labelText = ""
    private let manager = LocationManager()
    private let locationManager = CLLocationManager()
    private let weatherManager = DataManager()
    private let sceneView = ARSCNView()
    private let backButton = UIButton()
    
    // MARK: - Base Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentLocation()
        setupSceneView()
        setupBackButton()
    }
    
    // MARK: - Private Functions
    
    private func getCurrentLocation() {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func setupSceneView() {
        sceneView.delegate = self
        
        view.addSubview(sceneView)
        sceneView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }
    
    private func setupBackButton() {
        let image = UIImage(named: "back")?.withRenderingMode(.alwaysTemplate)
        backButton.setBackgroundImage(image, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        
        sceneView.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(Padding.p20)
            $0.leading.equalToSuperview().offset(Padding.p10)
        }
    }
    
    private func setLabelText() {
        let countryName = currentCity?.country ?? ""
        guard let cityName = currentCity?.name else {
            labelText = "\(countryName)\n\(temperature)º C"
            return
        }
        
        labelText = "\(countryName)\n\(cityName)\n\(temperature)º C"
    }
    
    private func getWeather() {
        guard let city = currentCity else {
            showAlert(message: "No location information")
            return
        }
        
        let date = NSDate()
        let timestamp = date.timeIntervalSince1970
        
        weatherManager.getTemperature(for: city, timestamp: timestamp) { (data, error) in
            guard let data = data else {
                return
            }
            
            self.format(data: data)
        }
    }
    
    private func format(data: Data) {
        guard let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as?  [String: AnyObject]) as [String : AnyObject]??) else {
            return
        }
        
        guard let currently = json?["currently"] as? [String: AnyObject],
            let temperature = currently["temperature"] as? Double else {
                return
        }
        
        let temperatureInCelsius = (temperature - 32) * 5 / 9
        self.temperature = Int(temperatureInCelsius)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func goBack() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isLabelDisplayed else { return }
        
        let touch = touches.first
        let location = touch?.location(in: sceneView)
        
        let hitResults = sceneView.hitTest(location!, types: .featurePoint)
        
        if let hitResult = hitResults.first {
            let transform = hitResult.worldTransform
            let position = SCNVector3(transform.columns.3.x, transform.columns.3.y + 0.1, transform.columns.3.z)
            
            let node = createNode(for: position)
            
            isLabelDisplayed = true
            sceneView.scene.rootNode.addChildNode(node)
        }
    }
    
    private func createNode(for location: SCNVector3) -> SCNNode {
        let node = SCNNode()
        node.position = location
        node.scale = SCNVector3(0.01, 0.01, 0.01)
        let text = SCNText(string: labelText, extrusionDepth: 2)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.white
        text.materials = [material]
        node.geometry = text
        
        return node
    }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard !isLabelDisplayed else { return nil }
        
        var node: SCNNode?
        
        if let planeAnchor = anchor as? ARPlaneAnchor {
            node = SCNNode()
            planeGeometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            planeGeometry.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            
            let planeNode = SCNNode(geometry: planeGeometry)
            planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-.pi / 2, 1, 0, 0)
            updateMaterial()
            
            node?.addChildNode(planeNode)
            anchors.append(planeAnchor)
        }
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard !isLabelDisplayed else { return }
        
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        if anchors.contains(planeAnchor) {
            if node.childNodes.count > 0 {
                let planeNode = node.childNodes.first!
                planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
                
                guard let plane = planeNode.geometry as? SCNPlane else { return }
                plane.width = CGFloat(planeAnchor.extent.x)
                plane.height = CGFloat(planeAnchor.extent.z)
                updateMaterial()
            }
        }
    }
    
    private func updateMaterial() {
        guard let material = planeGeometry.materials.first else { return }
        material.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(planeGeometry.width), Float(planeGeometry.height), 1)
    }
}

// MARK: - CLLocationManagerDelegate

extension CurrentWeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        let latitude = locValue.latitude
        let longitude = locValue.longitude
        
        self.manager.getCityAt(latitude: latitude, longitude: longitude) { (cityName, countryName, error) in
            guard let countryName = countryName else {
                    self.showAlert(message: "Could not find your location!")
                    return
            }
            
            guard let cityName = cityName else {
                let city = City(name: "", latitude: latitude, longitude: longitude, note: "", country: countryName)
                self.currentCity = city
                return
            }
            
            let city = City(name: cityName, latitude: latitude, longitude: longitude, note: "", country: countryName)
            self.currentCity = city
        }
    }
}
