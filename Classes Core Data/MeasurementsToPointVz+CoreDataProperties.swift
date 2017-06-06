//
//  MeasurementsToPointVz+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 31.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToPointVz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPointVz> {
        return NSFetchRequest<MeasurementsToPointVz>(entityName: "MeasurementsToPointVz")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var point: Points?
    @NSManaged public var station: Station?

}
