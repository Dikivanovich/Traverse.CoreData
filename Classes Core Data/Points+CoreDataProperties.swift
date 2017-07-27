//
//  Points+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 19.07.17.
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
    @NSManaged public var nextPicket: Bool
    @NSManaged public var mesureFromStationHz: NSSet?
    @NSManaged public var mesureFromStationVz: NSSet?
    @NSManaged public var station: Station?

}

// MARK: Generated accessors for mesureFromStationHz
extension Points {

    @objc(addMesureFromStationHzObject:)
    @NSManaged public func addToMesureFromStationHz(_ value: MeasurementsToPointHz)

    @objc(removeMesureFromStationHzObject:)
    @NSManaged public func removeFromMesureFromStationHz(_ value: MeasurementsToPointHz)

    @objc(addMesureFromStationHz:)
    @NSManaged public func addToMesureFromStationHz(_ values: NSSet)

    @objc(removeMesureFromStationHz:)
    @NSManaged public func removeFromMesureFromStationHz(_ values: NSSet)

}

// MARK: Generated accessors for mesureFromStationVz
extension Points {

    @objc(addMesureFromStationVzObject:)
    @NSManaged public func addToMesureFromStationVz(_ value: MeasurementsToPointVz)

    @objc(removeMesureFromStationVzObject:)
    @NSManaged public func removeFromMesureFromStationVz(_ value: MeasurementsToPointVz)

    @objc(addMesureFromStationVz:)
    @NSManaged public func addToMesureFromStationVz(_ values: NSSet)

    @objc(removeMesureFromStationVz:)
    @NSManaged public func removeFromMesureFromStationVz(_ values: NSSet)

}
