//
//  HorizontalAngle+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 11.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(HorizontalAngle)
public class HorizontalAngle: NSManagedObject {
    
    
     convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "HorizontalAngle"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        
    }


}
