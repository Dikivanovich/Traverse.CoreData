//
//  Point+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 17.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Point {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Point> {
        return NSFetchRequest<Point>(entityName: "Point")
    }

    @NSManaged public var dateInit: NSDate?
    @NSManaged public var fixed: Bool
    @NSManaged public var isStation: Bool
    @NSManaged public var namePoint: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var measurement: Measure?
    @NSManaged public var station: NSSet?

}

// MARK: Generated accessors for station
extension Point {

    @objc(addStationObject:)
    @NSManaged public func addToStation(_ value: Station)

    @objc(removeStationObject:)
    @NSManaged public func removeFromStation(_ value: Station)

    @objc(addStation:)
    @NSManaged public func addToStation(_ values: NSSet)

    @objc(removeStation:)
    @NSManaged public func removeFromStation(_ values: NSSet)

}
