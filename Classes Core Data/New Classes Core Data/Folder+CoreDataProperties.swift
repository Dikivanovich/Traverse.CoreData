//
//  Folder+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var name: String?
    @NSManaged public var files: NSSet?

}

// MARK: Generated accessors for files
extension Folder {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: File)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: File)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}
