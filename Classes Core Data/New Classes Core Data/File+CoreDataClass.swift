//
//  File+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(File)
public class File: NSManagedObject {
    
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "File"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }


}
