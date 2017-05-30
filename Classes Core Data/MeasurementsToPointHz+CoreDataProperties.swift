//
//  MeasurementsToPointHz+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 21.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToPointHz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPointHz> {
        return NSFetchRequest<MeasurementsToPointHz>(entityName: "MeasurementsToPointHz")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?
    @NSManaged public var point: Points?

}
