//
//  Reachability.swift
//  WeatherApp
//
//  Created by Stefan Lupascu on 24/11/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation
import SystemConfiguration

final class Reachability {
    static func isConnectedToNetwork() -> Bool {
        guard let reachability = SCNetworkReachabilityCreateWithName(nil, "www.goggle.com") else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability, &flags)
        
        return flags.contains(.reachable)
    }
}
