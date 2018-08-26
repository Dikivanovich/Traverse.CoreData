//
//  SumHorizontalAngles.swift
//  Traverse.CoreData
//
//  Created by Dik on 25.05.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//

import Foundation

/// Класс собирающий в себе данные измеренных углов хода. Инициализатором класса является массив измеренных углов по ходу. Свойствами класса являются: сумма измеренных углов по ходу, теоретическая сумма углов.
class SumHorizontalAngles {
    
    // MARK:- Properties:
    
    /// Массив измеренных углов.
    var horizontalAngles = [HorAngle]()
    
    /// Кортеж суммы измеренных углов по ходу.
    var sumAngles = (degree: Int16(), minutes: Int16(), second: Int16())
    
    var theoreticAvgAngles: Int16!
    
    
    /// Функция вычисления суммы измеренных углов по ходу.
    func avgAngles() {
        
        for angle in horizontalAngles {
            
            sumAngles.degree += angle.degree!
            
            sumAngles.minutes += angle.minutes!
            
            sumAngles.second += angle.seconds!
            
            // Проверка корректности колличества секунд в сумме измеренных углов:
            
            if sumAngles.second > 59 {
                
                sumAngles.second = sumAngles.second % 60
                
                sumAngles.minutes += 1
                
            }
            
            // Проверка корректности колличества минут в сумме измеренных углов:
            
            if sumAngles.minutes > 59 {
                
                sumAngles.minutes = sumAngles.minutes % 60
                
                sumAngles.degree += 1
                
            }
        }
        
        theoreticAvgAngles = Int16(180 * (horizontalAngles.count - 2))
        
    }
    
    init(horizontalAngles: [HorAngle]) {
        self.horizontalAngles = horizontalAngles
        avgAngles()
    }
    
}
    




