//
//  VerticalAngle+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension VerticalAngle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VerticalAngle> {
        return NSFetchRequest<VerticalAngle>(entityName: "VerticalAngle")
    }

    @NSManaged public var degree: Int16
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?

}
