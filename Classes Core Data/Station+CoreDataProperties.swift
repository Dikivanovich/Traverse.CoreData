//
//  Station+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 10.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Station {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station");
    }

    @NSManaged public var dateInitStation: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var nameStation: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?

}
