//
//  HorizontalAngle+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 14.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//
//

import Foundation
import CoreData


extension HorizontalAngle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HorizontalAngle> {
        return NSFetchRequest<HorizontalAngle>(entityName: "HorizontalAngle")
    }

    @NSManaged public var textValue: String?
    @NSManaged public var measure: Measure?
    @NSManaged public var verticalAngle: VerticalAngle?

}
