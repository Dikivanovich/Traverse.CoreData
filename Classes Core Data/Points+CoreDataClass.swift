//
//  Points+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 24.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(Points)
public class Points: NSManagedObject {
    
    convenience init() {
        
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Points"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        
    }
    
    
    

}
