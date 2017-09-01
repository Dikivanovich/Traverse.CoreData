//
//  FileName+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension FileName {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileName> {
        return NSFetchRequest<FileName>(entityName: "FileName")
    }

    @NSManaged public var name: String?
    @NSManaged public var file: File?

}
