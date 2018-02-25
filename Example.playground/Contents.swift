//: Playground - noun: a place where people can play

import UIKit

/// Класс, хранящий в себе данные угловых измерений на цель. Инициализацией класса является текстовое значение угла, полученное из соответствующего текстового поля интерфейса пользователя (textValue), или же из соответствующей строки текстового файла измерений при его парсинге (textDegree)
class Angle {
    
    /// Текстовое значение угла в виде "гг˚ мм' сс"". Имеет "наблюдатель" свойств, при изменении значения запускает основную функцию класса "private setup()->Void", которая устанавливает значения свойст гардусов, минут и секунд типа Int16. Так же эта функция срабатывает во время инциализации класса."
    private var textValue: String? {
    
        didSet {
            
            setup()
            
        }
        
    }
    
    /// Текствое значение угла в виде "гг° мм' мм"". Имеет "наблюдатель" свойства, при изменении значения запускает основую функцию класса "private setup()->Void", которая устанавливает значения свойств градусов, минут и секунд типа Int16. Так же эта функция срабатывает во время инициализации класса
    private var textDegree: String? {
     
        didSet {
            
            setup()
            
        }
        
    }
   
    /// Значение градусов угла в градусной мере исчисления.
    var degree: Int16? {
        
        didSet {
            
            self.angleAsText = getAnglAsText()
            
        }
        
    }
    
    /// Значение минут угла в градусной мере исчисления.
    var minutes: Int16? {
        
        didSet {
            
            self.angleAsText = getAnglAsText()
            
        }
        
    }
    
    /// Значение секунд угла в градусной мере исчисления.
    var seconds: Int16? {
        
        didSet {
            
            self.angleAsText = getAnglAsText()
            
        }
        
    }
    
    /// Текстовое значение измеренного угла.
    var angleAsText: String?
    
    
    /// Значение измеренного угла в радианах
    var angleInRadians: Double? {
        
        get {
            var value = 0.0
            if textDegree != nil || textValue != nil {
                value = Measurement(value: Double(degree!), unit: UnitAngle.degrees).converted(to: UnitAngle.radians).value + Measurement(value: Double(minutes!), unit: UnitAngle.arcMinutes).converted(to: UnitAngle.radians).value + Measurement(value: Double(seconds!), unit: UnitAngle.arcSeconds).converted(to: UnitAngle.radians).value
                }
            return value
        }
        
    }
        
    private func setup() {
        
        if textValue != "" || textDegree != "" {
                    
            var textAngle = textValue ?? textDegree
                    
            let replacingText: [String] = [UnitAngle.degrees.symbol, UnitAngle.arcMinutes.symbol,
                                           UnitAngle.arcSeconds.symbol, "˚", "'", "\"", "°"]
            for item in replacingText {
                textAngle = textAngle?.replacingOccurrences(of: item, with: "")
            }
                    let splityngText: [String.SubSequence] = textAngle!.split(separator: " ")
            let degreeText = String(splityngText[0])
            let minutesText = String(splityngText[1])
            let secondsText = String(splityngText[2])
            
            let degreeAngle = Measurement(value: Double(degreeText)!, unit: UnitAngle.degrees)
            let minutesAngle = Measurement(value: Double(minutesText)!, unit: UnitAngle.arcMinutes)
            let secondsAngle = Measurement(value: Double(secondsText)!, unit: UnitAngle.arcSeconds)
            
            degree = Int16(degreeAngle.value)
            minutes = Int16(minutesAngle.value)
            seconds = Int16(secondsAngle.value)
            
            
            print("\n\(self) Текстовое поле не пустое, выполнена установка значений измеренного угла")
            
        } else {
            
            print("\n\(self) Текстовое поле пустое")
            degree = nil
            minutes = nil
            seconds = nil

        }
        
    }
    
   /// Функция возращает значение измеренного угла в ггммсс, как текстовое значение.
   ///
   /// - Returns: Текстовое значение измеренного угла в ггммсс как текст (String).
   internal func getAnglAsText() -> String {
    if degree != nil && minutes != nil && seconds != nil {
        
       return  "\(degree!)\(UnitAngle.degrees.symbol) \(minutes!)\(UnitAngle.arcMinutes.symbol) \(seconds!)\(UnitAngle.arcSeconds.symbol)"
        
        } else {
    
    return ""
    
    }
    
}
    
    init(textValue: String?, textDegree: String?) {
        
        self.textValue = textValue
        self.textDegree = textDegree
        setup()
        
    }
    
}

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

/// Класс HorizontalAgle
class HorAngle: Angle {
    
    var leftCircle: Bool?
   private var verticalAngle: VertAngle?
    
  init(verticalAngle: VertAngle, textValue: String?, textDegree: String?) {
        
        self.verticalAngle = verticalAngle
    
       super.init(textValue: textValue, textDegree: textDegree)
    
     self.leftCircle = verticalAngle.leftCircle
    
    }
    
}

var verticalAngle = VertAngle(textValue: "180 34 54", textDegree: nil)

var horizontalAngle = HorAngle(verticalAngle: verticalAngle, textValue: nil, textDegree: "180˚ 00' 00\"")

horizontalAngle.seconds
horizontalAngle.angleAsText
horizontalAngle.angleInRadians









