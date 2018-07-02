//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Stefan on 02/07/2018.
//  Copyright © 2018 Stefan. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var note: String?

}
