//
//  MeasurementsToPointVz+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 31.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(MeasurementsToPointVz)
public class MeasurementsToPointVz: NSManagedObject {

    convenience init() {
        
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "MeasurementsToPointVz"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        
    }

    
    
    
}
