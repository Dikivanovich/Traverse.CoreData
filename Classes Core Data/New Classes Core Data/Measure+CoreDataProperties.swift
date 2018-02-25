//
//  Measure+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 17.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Measure {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Measure> {
        return NSFetchRequest<Measure>(entityName: "Measure")
    }

    @NSManaged public var forwardMeasure: NSNumber?
    @NSManaged public var horizontalDistance: NSDecimalNumber?
    @NSManaged public var horizontalAngle: HorizontalAngle?
    @NSManaged public var point: Point?
    @NSManaged public var station: Station?
    @NSManaged public var verticalAngle: VerticalAngle?

}
