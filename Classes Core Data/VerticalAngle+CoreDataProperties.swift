//
//  VerticalAngle+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 14.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//
//

import Foundation
import CoreData



extension VerticalAngle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VerticalAngle> {
        return NSFetchRequest<VerticalAngle>(entityName: "VerticalAngle")
    }

    @NSManaged public var textValue: String?
    @NSManaged public var measure: Measure?
    @NSManaged public var horizontalAngle: HorizontalAngle?

}
