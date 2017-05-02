//
//  Station+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }

    @NSManaged public var dateInitStation: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var nameStation: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var measurementsToPoint: NSSet?
    @NSManaged public var measurementsToStationBackSide: NSSet?
    @NSManaged public var measurementsToStationForwardSide: NSSet?
    @NSManaged public var point: NSSet?

}

// MARK: Generated accessors for measurementsToPoint
extension Station {

    @objc(addMeasurementsToPointObject:)
    @NSManaged public func addToMeasurementsToPoint(_ value: MeasurementsToPoint)

    @objc(removeMeasurementsToPointObject:)
    @NSManaged public func removeFromMeasurementsToPoint(_ value: MeasurementsToPoint)

    @objc(addMeasurementsToPoint:)
    @NSManaged public func addToMeasurementsToPoint(_ values: NSSet)

    @objc(removeMeasurementsToPoint:)
    @NSManaged public func removeFromMeasurementsToPoint(_ values: NSSet)

}

// MARK: Generated accessors for measurementsToStationBackSide
extension Station {

    @objc(addMeasurementsToStationBackSideObject:)
    @NSManaged public func addToMeasurementsToStationBackSide(_ value: MeasurementsToStationBackSide)

    @objc(removeMeasurementsToStationBackSideObject:)
    @NSManaged public func removeFromMeasurementsToStationBackSide(_ value: MeasurementsToStationBackSide)

    @objc(addMeasurementsToStationBackSide:)
    @NSManaged public func addToMeasurementsToStationBackSide(_ values: NSSet)

    @objc(removeMeasurementsToStationBackSide:)
    @NSManaged public func removeFromMeasurementsToStationBackSide(_ values: NSSet)

}

// MARK: Generated accessors for measurementsToStationForwardSide
extension Station {

    @objc(addMeasurementsToStationForwardSideObject:)
    @NSManaged public func addToMeasurementsToStationForwardSide(_ value: MeasurementsToStationForwardSide)

    @objc(removeMeasurementsToStationForwardSideObject:)
    @NSManaged public func removeFromMeasurementsToStationForwardSide(_ value: MeasurementsToStationForwardSide)

    @objc(addMeasurementsToStationForwardSide:)
    @NSManaged public func addToMeasurementsToStationForwardSide(_ values: NSSet)

    @objc(removeMeasurementsToStationForwardSide:)
    @NSManaged public func removeFromMeasurementsToStationForwardSide(_ values: NSSet)

}

// MARK: Generated accessors for point
extension Station {

    @objc(addPointObject:)
    @NSManaged public func addToPoint(_ value: Points)

    @objc(removePointObject:)
    @NSManaged public func removeFromPoint(_ value: Points)

    @objc(addPoint:)
    @NSManaged public func addToPoint(_ values: NSSet)

    @objc(removePoint:)
    @NSManaged public func removeFromPoint(_ values: NSSet)

}
