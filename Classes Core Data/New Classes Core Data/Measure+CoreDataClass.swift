//
//  Measure+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 17.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(Measure)
public class Measure: NSManagedObject {
    
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Measure"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }

    

}
