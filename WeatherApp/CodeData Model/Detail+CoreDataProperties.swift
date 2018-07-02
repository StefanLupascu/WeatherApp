//
//  Detail+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Stefan on 02/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//
//

import Foundation
import CoreData


extension Detail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Detail> {
        return NSFetchRequest<Detail>(entityName: "Detail")
    }

    @NSManaged public var temperature: Double
    @NSManaged public var humidity: Double
    @NSManaged public var pressure: Double
    @NSManaged public var summary: String?
    @NSManaged public var city: City?

}
