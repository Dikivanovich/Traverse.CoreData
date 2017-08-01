//
//  MeasurementsToPointHz+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 20.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(MeasurementsToPointHz)
public class MeasurementsToPointHz: NSManagedObject {

    convenience init() {
        
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "MeasurementsToPointHz"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
        
    }
    

    
    
}
