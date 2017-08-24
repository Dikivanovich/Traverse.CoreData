//
//  Measurement+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 18.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Measurement {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measurement> {
        return NSFetchRequest<Measurement>(entityName: "Measurement")
    }

    @NSManaged public var forwardMeasure: NSNumber?
    @NSManaged public var horizontalDistance: NSDecimalNumber?
    @NSManaged public var horizontalAngle: HorizontalAngle?
    @NSManaged public var point: Point?
    @NSManaged public var station: Station?
    @NSManaged public var verticalAngle: VerticalAngle?

}
