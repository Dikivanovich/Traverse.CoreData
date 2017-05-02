//
//  MeasurementsToStationBackSide+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension MeasurementsToStationBackSide {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToStationBackSide> {
        return NSFetchRequest<MeasurementsToStationBackSide>(entityName: "MeasurementsToStationBackSide")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?

}
