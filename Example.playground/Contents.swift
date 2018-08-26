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

var horizontalAngle = HorAngle(verticalAngle: verticalAngle, textValue: nil, textDegree: "180˚ 59' 00\"")

horizontalAngle.seconds
horizontalAngle.angleAsText
horizontalAngle.angleInRadians


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

let horizAngleTwo = HorAngle(verticalAngle: verticalAngle, textValue: "13 45 32", textDegree: nil)

let horizAngleThree = HorAngle(verticalAngle: verticalAngle, textValue: "14 56 34", textDegree: nil)

let prob = SumHorizontalAngles(horizontalAngles: [horizontalAngle, horizAngleTwo, horizAngleThree])

prob.sumAngles.degree
prob.sumAngles.minutes
prob.sumAngles.second
prob.theoreticAvgAngles


class MeasurementsAngles {
    
    //    Properties:
    
    /// Массив измеренных углов при КЛ
    var measurementLeftAngles = [Angle]()
    
    /// Массив измеренных углов при КП
    var measurementRightAngles = [Angle]()

    /// Массив отсчетов по горизонтальному лимбу при КЛ. Свойство я вляется одним из инициализаторов класса.
  
    var leftAngles = [HorAngle]()
    
    /// Массив отсчетов по горизонтальному лимбу при КП. Свойство является одним из инициализаторов класса.
 
    var rightAngles = [HorAngle]()
    
    /// Массив отсчетов по горизонтальному лимбу при КЛ, прямое измерение.
  
    var forwardLeftAngles = [HorAngle]()

    /// Массив отсчетов по вертикальному лимбу при КЛ, обратное измерение.
  
    var rewardLeftAngles = [HorAngle]()
    
    /// Массив отсчетов по горизонтальному лимбу при КП, прямое измерение.

    var forwardRightAngles = [HorAngle]()
    
    /// Массив отчетов по горизонтальному лимбу при КП, обратное измерение.
    
    var rewardRightAngle = [HorAngle]()
    
    
    /// Вычисление измеренного угла между пикетами в точке стояния.
    private func returnMeasurementsAngles() {
        
        // MARK:-    Разделение массива измерений при КЛ на прямое и обратное.
        
        /// Коэффициент, показывающий порядковый номер измерения в массиве leftAngles.
        var k = 0
        
        for leftAngle in leftAngles {
            
            if k%2 == 0 { //прямое измерение на пикет:
                
                forwardLeftAngles.append(leftAngle)
                
                k += 1
                
            } else { //обратное измерение на пикет:
                
                rewardLeftAngles.append(leftAngle)
                
                k += 1
                
            }
            
            
            
        }
        // MARK:-    Разделение массива измерний при КП на прямое и обратное.
        
        /// Коэффициент, показывающий порядковый номер измерения в массиве leftAngles.
        var i = 0
        for rightAngle in rightAngles {

            if i%2 == 0 {// прямое измерение на пикет:
                
              forwardRightAngles.append(rightAngle)
               
                i += 1
                
            } else {// обратное измерение на пикет:
                
                rewardRightAngle.append(rightAngle)
                
                i += 1
                
            }
            
        }
     
        // MARK:-   Вычисление измеренных углов при КП и КЛ.
//        Для вычисления измеренных углов при КП и КЛ должно выполняться следующее условие - колличество литералов массива отчетов при любом круге и направлении измерения должно совпадать.
        
        if forwardLeftAngles.count == rewardLeftAngles.count && forwardRightAngles.count == rewardRightAngle.count {
            
            /// Коэффициент итерациЙ по массивам отсчетов по горизонтальному лимбу при КЛ
            var l = 0
            
            /// Коэффициент итераций по массивам отсчетов по горизонтальному лимбу при КП
            var r = 0
            
            //заполнение массива измеренных углов при КЛ:
            for forwardLeftAngle in forwardLeftAngles {
                
                let degree = forwardLeftAngle.degree! - rewardLeftAngles[l].degree!
                
                let minutes = forwardLeftAngle.minutes! - rewardLeftAngles[l].minutes!
                    
                let seconds = forwardLeftAngle.seconds! - rewardLeftAngles[l].seconds!
                
                let angle = Angle(textValue: "\(degree) \(minutes) \(seconds)", textDegree: nil)
                
                measurementLeftAngles.append(angle)
                    
                l += 1
                        
                    }
           
            //заполнение массива измеренных углов при КП:
            for forwardRightAngle in forwardRightAngles {
                
                let degree = forwardRightAngle.degree! - rewardRightAngle[r].degree!
                
                let minutes = forwardRightAngle.minutes! - rewardRightAngle[r].minutes!
                
                let seconds = forwardRightAngle.seconds! - rewardRightAngle[r].seconds!
                
                let angle = Angle(textValue: "\(degree) \(minutes) \(seconds)", textDegree: nil)
                
                measurementRightAngles.append(angle)
                
                r += 1
                
            }
            
                }
                
                
            }
    
    init(leftAngles: [HorAngle], rightAngles: [HorAngle]) {
        self.leftAngles = leftAngles
        self.rightAngles = rightAngles
        returnMeasurementsAngles()
    }
            
            
        }
        

    
    let leftForwardAngleOne = HorAngle(verticalAngle: verticalAngle, textValue: "90 0 0", textDegree: nil)

    let leftForwardAngleTwo = HorAngle(verticalAngle: verticalAngle, textValue: "90 0 0", textDegree: nil)

    let leftForwardAngleThree = HorAngle(verticalAngle: verticalAngle, textValue: "90 0 0", textDegree: nil)

    let leftRewardAngleOne = HorAngle(verticalAngle: verticalAngle, textValue: "0 00 00", textDegree: nil)

    let leftRewardAngleTwo = HorAngle(verticalAngle: verticalAngle, textValue: "0 00 00", textDegree: nil)

    let leftRewardAngleThree = HorAngle(verticalAngle: verticalAngle, textValue: "0 00 00", textDegree: nil)

    let rightForwardAngleOne = HorAngle(verticalAngle: verticalAngle, textValue: "180 0 0", textDegree: nil)

    let rightForwardAngleTwo = HorAngle(verticalAngle: verticalAngle, textValue: "180 0 0", textDegree: nil)

    let rightForwardAngleThree = HorAngle(verticalAngle: verticalAngle, textValue: "180 0 0", textDegree: nil)

    let rightRewardAngleOne = HorAngle(verticalAngle: verticalAngle, textValue: "90 00 00", textDegree: nil)

    let rightRewardAngleTwo = HorAngle(verticalAngle: verticalAngle, textValue: "90 00 00", textDegree: nil)

    let rightRewardAngleThree = HorAngle(verticalAngle: verticalAngle, textValue: "90 00 00", textDegree: nil)

    let measureAngles = MeasurementsAngles(leftAngles: [leftForwardAngleOne, leftRewardAngleOne, leftForwardAngleTwo, leftRewardAngleTwo, leftForwardAngleThree, leftRewardAngleThree], rightAngles: [rightForwardAngleOne, rightRewardAngleTwo, rightForwardAngleTwo, rightRewardAngleTwo, rightForwardAngleThree, rightRewardAngleThree])

measureAngles.forwardLeftAngles.count
measureAngles.forwardRightAngles.count
measureAngles.rewardLeftAngles.count
measureAngles.rewardRightAngle.count
measureAngles.forwardLeftAngles[0].angleAsText
measureAngles.rewardLeftAngles[0].angleAsText
measureAngles.forwardRightAngles[2].angleAsText
measureAngles.rewardRightAngle[2].angleAsText
measureAngles.measurementLeftAngles[0].angleAsText
measureAngles.measurementRightAngles[0].angleAsText
measureAngles.measurementLeftAngles[0].angleInRadians


// пример конвертации угла в радианы, а именно ковертация градусов пинут и секунд:

var radAngle = Measurement(value: measureAngles.measurementLeftAngles[0].angleInRadians!, unit: UnitAngle.radians)
radAngle.converted(to: UnitAngle.degrees)
var arcMinutes = Measurement(value:radAngle.converted(to: UnitAngle.degrees).value.truncatingRemainder(dividingBy: 1) * 60 , unit: UnitAngle.arcMinutes)




