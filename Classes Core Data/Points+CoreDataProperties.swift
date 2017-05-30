//
//  Points+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 21.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Points {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Points> {
        return NSFetchRequest<Points>(entityName: "Points")
    }

    @NSManaged public var dateMeasure: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var namePoint: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var station: Station?
    @NSManaged public var mesureFromStation: NSSet?

}

// MARK: Generated accessors for mesureFromStation
extension Points {

    @objc(addMesureFromStationObject:)
    @NSManaged public func addToMesureFromStation(_ value: MeasurementsToPointHz)

    @objc(removeMesureFromStationObject:)
    @NSManaged public func removeFromMesureFromStation(_ value: MeasurementsToPointHz)

    @objc(addMesureFromStation:)
    @NSManaged public func addToMesureFromStation(_ values: NSSet)

    @objc(removeMesureFromStation:)
    @NSManaged public func removeFromMesureFromStation(_ values: NSSet)

}
