//
//  File.swift
//  WeatherApp
//
//  Created by Stefan on 26/06/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//

import Foundation

struct API {
    
    static let APIKey = "b575743a969d064f18d37a4249f3fd4f"
    static let BaseURL = URL(string: "https://api.forecast.io/forecast/")!
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(APIKey)
    }
}
