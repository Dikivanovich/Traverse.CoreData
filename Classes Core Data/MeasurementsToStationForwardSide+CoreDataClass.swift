//
//  MeasurementsToStationForwardSide+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(MeasurementsToStationForwardSide)
public class MeasurementsToStationForwardSide: NSManagedObject {

    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "MeasurementsToStationForwardSide"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }
    
}
