//
//  MeasurementsToPointVz+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 24.07.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToPointVz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPointVz> {
        return NSFetchRequest<MeasurementsToPointVz>(entityName: "MeasurementsToPointVz")
    }

    @NSManaged public var degree: NSObject?
    @NSManaged public var minutes: NSObject?
    @NSManaged public var seconds: NSObject?
    @NSManaged public var point: Points?
    @NSManaged public var station: Station?

}
