//
//  ResultMeasureClass.swift
//  Traverse.CoreData
//
//  Created by Dik on 25.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// Класс для интеграции в интерфейс пользователя. Служит для реализации действий при нажатии кнопки "Рассчитать"
///
/// Инициализаторы:
///
/// - viewController - Контроллер, в котором будет реализовываться кнопка вычисления хода. По нажатию кнопки в дальнейшем, по ходу вычисления, могут возникнуть ошибки, которые мог совершить пользователь, при вводе данных, об этом ему должна сообщать система, для этого должен всплывать контроллер предупреждения ошибки. Для его реализации нужно указать контроллер, в котором должно всплыть окно предупреждения.
class ResultMeasure { /// #Переработать вычисление!!!
    
    //      MARK:- Properies
    
    /// Контроллер, в котором будут всплывать уведомления об ошибке вычисления хода.
    var viewController: UIViewController!
    
    /// Массив станций, с которых были выполнены измеения.
    var stations = [Station]()
    
    
    /// Кортеж с отчетами по горизонтальному, вертикальному кругу, массив с измеренными углами, а так же горизонтальное проложение между станциями.
    var angles = (left: [Double](), right: [Double](), delta: [Double](), sumAngles: Double())
    
    /// Горизонтальные проложения, выполненные при левом и правом круге.
    var distances = (left: [NSNumber](), right: [NSNumber]())
    
    /// Теоретическая сумма измеренных углов в ходе.
    var theoreticSumAngles = Double()
    
    var index = 0
    
    
    /// Функция возвращает класс VertAngle и Horangle, которые хранят в себе все свойства одноименных углов
    ///
    /// - Parameters:
    ///   - verticalAngle: текстовое значение измеренного вертикального угла, в офрмате гг° мм' сс", которое хранится в модели данных.
    ///   - horizontalAngle: текстовое значение измеренного горизонтального угла, в офрмате гг° мм' сс", которое хранится в модели данных.
    /// - Returns: Возвращается кортеж с значениями типа VertAngle, HorAngle
    func returnAngles(verticalAngle: VerticalAngle, horizontalAngle: HorizontalAngle) -> (VerticalAngle: VertAngle, HorizontalAngle: HorAngle) {
        
        let verticalAngle = VertAngle(textValue: verticalAngle.textValue!, textDegree: nil)
        
        let horiazontalAngle = HorAngle(verticalAngle: verticalAngle, textValue: horizontalAngle.textValue!, textDegree: nil)
        
        return (verticalAngle, horiazontalAngle)
        
    }
    
    
    /// Функция для заполнения и вычисления свойств класса.
    func setup() {
        
        let fetchRequest: NSFetchRequest = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let dateDescripor = NSSortDescriptor(key: "dateInitStation", ascending: true)
        fetchRequest.sortDescriptors = [dateDescripor]
        
        do {
            
            stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch  {
            
            print(error)
            
        }
        
        for station in stations {
            
            let sortDescriptorPoints = NSSortDescriptor(key: "dateInit", ascending: true)
            
            let pts = station.point?.sortedArray(using: [sortDescriptorPoints]) as! [Point]
            
            for point in pts {
                
                if point.isStation == true { // точка является станцией
                    
                    let anglesForMeasure = returnAngles(verticalAngle: (point.measurement?.verticalAngle)!, horizontalAngle: (point.measurement?.horizontalAngle)!)
                    
                    if anglesForMeasure.0.leftCircle! == true { // измерение при КЛ
                        
                        angles.left.append(anglesForMeasure.1.angleInRadians!)
                        
                        distances.left.append(point.measurement!.horizontalDistance!)
                        
                    } else { // измерение при КП
                        
                        angles.right.append(anglesForMeasure.1.angleInRadians!)
                        
                        distances.right.append(point.measurement!.horizontalDistance!)
                        
                    }
                    
                }
                
            }
            
        }
        
        differenceAngle(forAngles: &angles.left, viewController: viewController)
        differenceAngle(forAngles: &angles.right, viewController: viewController)
        
        theoreticSumAngles = Double.pi * Double(stations.count - 2)
        
        for leftAngle in angles.left {
            
            angles.delta.append((leftAngle + angles.right[index])/2)
            
            index += 1
            
        }
        
        for delta in angles.delta {
            
            angles.sumAngles += delta
            
        }
        
        /// Функция для проверки работоспособнсти свойств и методов класса, заполнения переменных данными.
        func check() {
            
            print("\nСписок станций:\(stations)")
            print("\nКоличество левых углов: \(angles.left.count)")
            print("\nКоличество правых углов: \(angles.right.count)")
            print("\nСумма углов: \(angles.sumAngles)")
            print("\nТеретическая сумма углов: \(theoreticSumAngles)")
            
        }
        
        check()
    }
    
    init(indexPath: IndexPath, viewController: UIViewController) {
        
        self.viewController = viewController
        
        setup()
        
    }
    
}
