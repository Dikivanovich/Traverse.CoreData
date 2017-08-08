//
//  MeasurementsToStationForwardSide+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToStationForwardSide {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToStationForwardSide> {
        return NSFetchRequest<MeasurementsToStationForwardSide>(entityName: "MeasurementsToStationForwardSide")
    }

    @NSManaged public var distance: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var station: Station?
    @NSManaged public var horizontalAngle: NSSet?
    @NSManaged public var verticalAngle: NSSet?

}

// MARK: Generated accessors for horizontalAngle
extension MeasurementsToStationForwardSide {

    @objc(addHorizontalAngleObject:)
    @NSManaged public func addToHorizontalAngle(_ value: HorizontalAngle)

    @objc(removeHorizontalAngleObject:)
    @NSManaged public func removeFromHorizontalAngle(_ value: HorizontalAngle)

    @objc(addHorizontalAngle:)
    @NSManaged public func addToHorizontalAngle(_ values: NSSet)

    @objc(removeHorizontalAngle:)
    @NSManaged public func removeFromHorizontalAngle(_ values: NSSet)

}

// MARK: Generated accessors for verticalAngle
extension MeasurementsToStationForwardSide {

    @objc(addVerticalAngleObject:)
    @NSManaged public func addToVerticalAngle(_ value: VerticalAngle)

    @objc(removeVerticalAngleObject:)
    @NSManaged public func removeFromVerticalAngle(_ value: VerticalAngle)

    @objc(addVerticalAngle:)
    @NSManaged public func addToVerticalAngle(_ values: NSSet)

    @objc(removeVerticalAngle:)
    @NSManaged public func removeFromVerticalAngle(_ values: NSSet)

}
