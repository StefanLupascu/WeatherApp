//
//  DemoPageViewController.swift
//  WeatherApp
//
//  Created by Stefan on 09/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

class DemoPageViewController: UIPageViewController {
    // MARK: - Properties
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Demo"
        dataSource = self
        
        setupPages()
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - Private Functions

    private func setupPages() {
        let locationsDemoViewController = LocationsDemoViewController()
        let detailsDemoViewController = DetailsDemoViewController()
        let mapDemoViewController = MapDemoViewController()
        
        pages = [locationsDemoViewController, detailsDemoViewController, mapDemoViewController]
    }
    
    private func setupButton() {
        let button = UIBarButtonItem(title: "Go to app", style: .plain, target: self, action: #selector(startApp(sender:)))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func startApp(sender: UIBarButtonItem) {
        let locationsViewController = LocationsViewController()
        navigationController?.pushViewController(locationsViewController, animated: true)
    }
}

extension DemoPageViewController: UIPageViewControllerDataSource {
    // MARK: - Page View Handling
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else {
            return nil
        }
        guard currentIndex < pages.count - 1 else {
            setupButton()
            return nil
        }
        
//        if currentIndex == pages.count - 1 {
//            setupButton()
//        }
        
        return pages[currentIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.index(of: viewController) else {
            return nil
        }
        guard currentIndex > 0 else {
            return nil
        }
        
        return pages[currentIndex - 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = pages.first,
            let firstViewControllerIndex = pages.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
