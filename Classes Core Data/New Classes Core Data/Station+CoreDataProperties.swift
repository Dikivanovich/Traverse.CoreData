//
//  Station+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 18.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var dateInitStation: NSDate?
    @NSManaged public var fixed: Bool
    @NSManaged public var nameStation: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var measurement: NSSet?
    @NSManaged public var point: NSSet?

}

// MARK: Generated accessors for measurement
extension Station {

    @objc(addMeasurementObject:)
    @NSManaged public func addToMeasurement(_ value: Measurement)

    @objc(removeMeasurementObject:)
    @NSManaged public func removeFromMeasurement(_ value: Measurement)

    @objc(addMeasurement:)
    @NSManaged public func addToMeasurement(_ values: NSSet)

    @objc(removeMeasurement:)
    @NSManaged public func removeFromMeasurement(_ values: NSSet)

}

// MARK: Generated accessors for point
extension Station {

    @objc(addPointObject:)
    @NSManaged public func addToPoint(_ value: Point)

    @objc(removePointObject:)
    @NSManaged public func removeFromPoint(_ value: Point)

    @objc(addPoint:)
    @NSManaged public func addToPoint(_ values: NSSet)

    @objc(removePoint:)
    @NSManaged public func removeFromPoint(_ values: NSSet)

}
