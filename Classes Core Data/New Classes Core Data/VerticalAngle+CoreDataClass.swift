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

/// Класс VerticalAngle является классом модели данных (CoreData).
///
/// Свойства:
/// textValue: String - текстовое значение измеренного вертикального угла в формате гг˚ мм' сс".
/// measure: Measure - данное свойство ссылается на станцию, с которой было выполнено измерение, и, соотвественно, имеет доступ ко всем ее свойствам.
/// horizontalAngle: HorizontalAngle? - данное свойство ссылается на горизонтальный угол, при котором было выполенено измерение вертикального угла.
public class VerticalAngle: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "VerticalAngle"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }


}
