//
//  VerticalAngle+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 11.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(VerticalAngle)
public class VerticalAngle: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "VerticalAngle"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }


}
