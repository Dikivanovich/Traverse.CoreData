//
//  Measurement+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 11.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(Measurement)
public class Measurement: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Measurement"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }


}
