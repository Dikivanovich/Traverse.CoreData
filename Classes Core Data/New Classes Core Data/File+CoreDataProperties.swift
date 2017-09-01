//
//  File+CoreDataProperties.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData


extension File {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<File> {
        return NSFetchRequest<File>(entityName: "File")
    }

    @NSManaged public var file: NSData?
    @NSManaged public var folder: Folder?
    @NSManaged public var fileName: FileName?

}
