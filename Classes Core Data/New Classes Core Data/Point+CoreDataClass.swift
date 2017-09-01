//
//  Point+CoreDataClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 11.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData

@objc(Point)
public class Point: NSManagedObject {
    
    func returnStringDate() -> String {
        
        let dateFormater = DateFormatter() //инициализация формата даты
        dateFormater.dateFormat = "dd-MM-yyyy HH:mm" //установка формата даты
        let stringDate = dateFormater.string(from: self.dateInit! as Date)
        
        return stringDate
    }
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Point"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }

}
