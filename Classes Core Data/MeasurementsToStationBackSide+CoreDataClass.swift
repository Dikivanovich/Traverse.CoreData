//
//  MeasurementsToStationBackSide+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 24.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(MeasurementsToStationBackSide)
public class MeasurementsToStationBackSide: NSManagedObject {

    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "MeasurementsToStationBackSide"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
