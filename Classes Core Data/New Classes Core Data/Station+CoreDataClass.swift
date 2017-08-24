//
//  Station+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 11.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(Station)
public class Station: NSManagedObject {
    
    func returnStringDate() -> String {
        
        let dateFormater = DateFormatter() //инициализация формата даты
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm" //установка формата даты
        
        return dateFormater.string(from: self.dateInitStation! as Date)
        
    }
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Station"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }

}
