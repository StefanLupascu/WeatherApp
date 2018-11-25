//
//  UIViewController+Extensions.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import UIKit

extension UIViewController {
    func setNavigationBar() {
        guard let navigationController = navigationController else {
            fatalError("Navigation Controller doesn't exist!")
        }
        
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
}
