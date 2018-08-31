//
//  VertAngle.swift
//  Traverse.CoreData
//
//  Created by Dik on 07.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//

import Foundation
class VertAngle: Angle {
    
    override var degree: Int16? {
        
        didSet { // добавление наблюдателя свойств при изменении значения угла срабатывают функции назначения положения вертикального круга и изменения значения угла, как текст
            
            self.setCircle()
            super.angleAsText = getAnglAsText()
            
        }
        
    }
    
    override var minutes: Int16? {
        
        didSet { // добавление наблюдателя свойств при изменении значения угла срабатывают функции назначения положения вертикального круга и изменения значения угла, как текст
            
            self.setCircle()
            super.angleAsText = getAnglAsText()
            
        }
        
    }
    
    override var seconds: Int16? {
        
        didSet { // добавление наблюдателя свойств при изменении значения угла срабатывают функции назначения положения вертикального круга и изменения значения угла, как текст
            
            self.setCircle()
            super.angleAsText = getAnglAsText()
            
        }
        
    }
    
    
    /// Положение вертикального круга при взятии показаний с горизонтального круга (КП, КЛ).
    var leftCircle: Bool?
    
    /// Функция установки положения вертикального круга. Если отчет по вертикальному кругу больше 180° - измерение горизонтальго угла выполнено при круге право (КП)
    private func setCircle() {
        
        /// Значение угла 180° в радианах
        let value = Double.pi
        
        if degree != nil && seconds != nil && minutes != nil {
            
            if angleInRadians! > value {
                
                leftCircle = false
                
                print("Вертикальный угол больше 180 гардусов")
                
                
            } else {
                
                leftCircle = true
                
                print("Вертикальный угол меньше 180 гардусов")
                
            }
            
        }
        
    }
    
    override init(textValue: String?, textDegree: String?) {
        
        super.init(textValue: textValue, textDegree: textDegree)
        setCircle()
    }
    
}
