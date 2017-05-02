//
//  MeasurementsToPoint+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPoint> {
        return NSFetchRequest<MeasurementsToPoint>(entityName: "MeasurementsToPoint")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?

}
