//
//  HorAngle.swift
//  Traverse.CoreData
//
//  Created by Dik on 09.02.18.
//  Copyright © 2018 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit

/// Класс HorAngle.
///
/// Класс хранит в себе данные об измерении горизонтального угла.
/// Инициализаторы:
///
/// - verticalAngle - тип класса VerticalAngle, несущий в себе информацию об измеренном вертикальном угле.
///
/// - textValue - значение измеренного угла из текстового поля, взятое из интерфейса пльзователя. При инициализации класса в прасинге данный инициализатор объявляется как nil.
///
/// - textDegree - значение измеренного угла, получаемое во время парсинга файла журнала измерений. При инициализации класса в графическом интрефейсе данный инициализатор объявляется как nil.
class HorAngle: Angle {
    
    var leftCircle: Bool?
    private var verticalAngle: VertAngle?
    
    init(verticalAngle: VertAngle, textValue: String?, textDegree: String?) {
        
        self.verticalAngle = verticalAngle
        
        super.init(textValue: textValue, textDegree: textDegree)
        
        self.leftCircle = verticalAngle.leftCircle
        
    }
    
}

