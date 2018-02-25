//
//  ExtentionResultMeasure.swift
//  Traverse.CoreData
//
//  Created by Dik on 25.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit

extension ResultMeasure {
    
    
    /// Функция выполняет вычисление измеренных углов. Она разбивает массив на парные значения, и вычитает из заднего значения переднее.
    ///
    /// - Parameters:
    ///
    ///   - forAngles - Аргументом функции является массив типа Double, который хранит отчеты угла в радианах.
    ///   - viewController - Контролле в котором будет отображаться предупреждение об ошибке, при необходимости.
    func  differenceAngle(forAngles: inout [Double], viewController: UIViewController) {
        
        //MARK:- Проверка на достаточность измерений для вычисления хода:
        if forAngles.count % 2 != 0 || forAngles.count == 0 { //Реализация предупреждения (alert), если количество измеренных углов нечетное и пустое:
            
            let alert = UIAlertController.init(title: "Ошибка", message: "Недостаточно измерений в точках хода при левом и/или правом круге! Проверьте журнал  измерений", preferredStyle: .alert)
            
            let action = UIAlertAction.init(title: "Ок", style: .default, handler: nil)
            
            alert.addAction(action)
            
            viewController.present(alert, animated: true, completion: nil)
            
        } else {
            
            var doubleArray = [Double]()
            var forwardMeasures = [Double]()
            var backSideMeasures = [Double]()
            
            let circleInRadians = Measurement(value: 360.0, unit: UnitAngle.degrees).converted(to: .radians).value
            
            /// Индекс распеределения измерений в массиве на прямое и обратное. Если индекс имеет четное значение, измерение добавляется в свойство измерения задней точки стояния.
            var i = 0
            var n = 0
            
            for angle in forAngles {
                
                if i%2 == 0 { // если измерение в массиве имеет четный порядковый номер
                    
                    backSideMeasures.append(angle)
                    
                } else {
                    
                    forwardMeasures.append(angle)
                    
                }
                
                i += 1
                
            }
            
            if i == forAngles.count && (forwardMeasures.count + backSideMeasures.count)%2 == 0 { // проверка количества измерений и их парность
                
                for item in forwardMeasures {
                    
                    while n != forwardMeasures.count  {
                        
                        var measurementAngle = item - backSideMeasures[n]
                        
                        if measurementAngle < 0 {
                            
                            
                            measurementAngle += circleInRadians
                            
                        }
                        
                        doubleArray.append(measurementAngle)
                        
                        n += 1
                    }
                    
                }
                
            }
            
            forAngles.removeAll()
            forAngles = doubleArray
            
        }
        
    }
    
}
