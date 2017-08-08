//
//  Classes.swift
//  Traverse
//
//  Created by Dik on 14.03.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CurrentData {
    
    static let instance = CurrentData()
    
    
    func returnDate() -> String
    {
        let date = NSDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormater.string(from: date as Date)
        return dateString
    }
    
    private init() {}
}

class CustomCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7946271728, green: 0.6012833646, blue: 0.9686274529, alpha: 0.5649882277).cgColor
        self.clipsToBounds = true
        
        
    }
    
    
}

/// Класс для настройки, кастомизации InputView текстовых полей, а так же преобразования значений типов
class Customisation {
    
    /// Инициализация класса Customisation
    static let instance = Customisation()
    
    private init() {}
    
    
    /// Данная функция реализует кастомную клавиатуру для указанного в аргументе текстового поля.
    ///
    /// - Parameters:
    ///   - textField: Текстовое поле, над которым будет выполнена процедура настройки.
    ///   - placeholder: Текст, который должен указываться в placeholder выбранного текстового поля.
    func customozationTextField(textField: UITextField, placeholder: String?, backgroundColor: UIColor) {
        let myCustomKeyboard = MyCustomKeyboard.init().loadFromNib()
        myCustomKeyboard.backgroundColor = backgroundColor
        textField.inputView = myCustomKeyboard
        if placeholder != nil {
            textField.placeholder = "координата \(placeholder!)"
        } else {
            
            textField.placeholder = "Горизонтальное проложение"
        }
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        let label = UILabel(frame: .init(x: -18, y: -11, width: 50, height: 50))
        label.textColor = #colorLiteral(red: 0.4691409734, green: 0.6283831361, blue: 0.9686274529, alpha: 1)
        if placeholder != nil { label.text = "\(placeholder!):"}
        textField.addSubview(label)
        
    }
    
    /// Данная функция реализует Custom Picker View для указанного в аргументе текстового поля.
    ///
    /// - Parameters:
    ///   - textField: Текстовое поле, над которым будет выполнена процедура настройки.
    ///   - placeholder: Текст, который должен указываться в placeholder выбранного текстового поля.
    func customozationTextFieldForPicker(textField: UITextField, placeholder: String, showSideCircle: Bool) {
        
        let pickerView = PickerView.init()
        pickerView.configPickerView(textField: textField, dataForPicker: DataModel.getData(), showSideCircle: showSideCircle)
        textField.inputView = pickerView
        textField.placeholder = "\(placeholder)"
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFontTextStyle.title1.rawValue, size: 20)
        
        
    }
    
    /// Данная функция преобразовывает значение типа NSDecimalNumber в текст с текущим региональным разделителем десятичной дроби
    ///
    /// - Parameter value: Значение типа NSDecimalNumber, которое будет преобразовано в текст
    /// - Returns: Возвращает опциональный текст String?
    
    func returnCurrencyDecimalSeparatorText(value: NSDecimalNumber?) -> String? {
        
        let decimalSeparate = NumberFormatter().currencyDecimalSeparator
        
        var textValueWithDecimalSeparate: String? {
            
            get{
                
                var nSDecimalStringValue = value?.stringValue
                
                if nSDecimalStringValue?.contains(",") == true {
                    
                    nSDecimalStringValue = nSDecimalStringValue?.replacingOccurrences(of: ",", with: decimalSeparate!)
                    
                } else if value?.stringValue.contains(".") == true {
                    
                    nSDecimalStringValue = nSDecimalStringValue?.replacingOccurrences(of: ".", with: decimalSeparate!)
                    
                }
                
                return nSDecimalStringValue
                
            }
            
        }
        
        return textValueWithDecimalSeparate
    }
    
    /// Функция преобразования содержимого текстового поля в NSDecimalNumber, если оно соответствует данному значению типа.
    ///
    /// - Parameter textField: Текстовое поле для преобразования содержимого.
    /// - Returns: Функция возвращает опциональный NSDecimalNumber?, если содержимое текстового поля соответствует данному значению типа.
    func returnTextAsDecimalNumber(textField: UITextField) -> NSDecimalNumber? {
        
        
        var textFieldValue: String? {
            
            get{
                
                if textField.text?.contains(",") == true {
                    return textField.text?.replacingOccurrences(of: ",", with: ".")
                }
                
                return textField.text
                
            }
            
        }
        print("\nПреобразованное значение текстового поля: \(textFieldValue!)")
        return NSDecimalNumber(string: textFieldValue)
        
    }
    
    deinit {
        print("\n\(self)Экземпляр класса удален из оперативной памяти")
    }
    
}

class MeasurementAngle {
    
    private var textField: UITextField?
    var degree: Int16?
    var minutes: Int16?
    var seconds: Int16?
    var textValue: String?
    var radianValue: NSDecimalNumber?
    
    private func setup() {
        
        if textField?.text != "" && textField?.text != nil {
            var textAngle = textField?.text!
            let replacingText: [String] = ["˚", "'", "\""]
            for item in replacingText {
                textAngle = textAngle?.replacingOccurrences(of: item, with: "")
            }
            let splityngText: [String.CharacterView] = textAngle!.characters.split(separator: " ")
            let degreeText = String(splityngText[0])
            let minutesText = String(splityngText[1])
            let secondsText = String(splityngText[2])
            
            degree = Int16(degreeText)!
            minutes = Int16(minutesText)!
            seconds = Int16(secondsText)!
            textValue = "\(degree!)˚ " + "\(minutes!)' " + "\(seconds!)\""
            radianValue = NSDecimalNumber(value: Double(degree!) + Double(minutes!)/60 + Double(seconds!)/60)
            
            print("\n\(self)Текстовое поле не пустое, выполнена установка значений измеренного угла")
            
        } else {
            
            print("\n\(self)Текстовое поле пустое")
            degree = nil
            minutes = nil
            seconds = nil
            textValue = nil
            radianValue = nil
            
        }
        
    }
    init(textField: UITextField?) {
        self.textField = textField
        setup()
    }
    
    deinit {
        print("\n\(self)Экземпляр класса удален из оператвной памяти")
    }
    
}

class Angle: MeasurementAngle {
    
    var backSideMeasure = (nameStation: [String](), measure: [[MeasurementsToStationBackSide]]())
    var backSideMeasureHorizontalAngle = [HorizontalAngle]()
    var forwardMeasure = (nameStation: [String](), measure: [[MeasurementsToStationForwardSide]]())
    
    func setup() {
        
        let backSideMeasureHorizontalAngles = backSideMeasure.measure
        
        for item in backSideMeasureHorizontalAngles {
            var count = Int()
            backSideMeasureHorizontalAngle = item[count].horizontalAngle?.allObjects as! [HorizontalAngle]
            count += 1
            
            
        }
        
        print("Колличество измеренных обратных горизонтальных углов \(backSideMeasureHorizontalAngles.count)")
        
    }
    
    init(backSideMeasure: (nameStation: [String], measure: [[MeasurementsToStationBackSide]]), forwardMeasure: (nameStation: [String], measure: [[MeasurementsToStationForwardSide]])) {
        
        
        self.backSideMeasure = backSideMeasure
        self.forwardMeasure = forwardMeasure
        
        super.init(textField: nil)
        setup()
    }
    
    
    
    
    
    
    
}

class ResultMeasure {
    
    var indexPath: IndexPath?
  
    var stations: [Station]?
    
    var forwardSideMeasures = (nameStation: [String](), measure: [[MeasurementsToStationForwardSide]]())
    
    var backSideMeasure = (nameStation: [String](), measure: [[MeasurementsToStationBackSide]]())
    
    func setup() {
        
       
        
        let fetchRequest: NSFetchRequest = Station.fetchRequest()
        
        do {
            
            stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            for item in stations! {
                
                forwardSideMeasures.nameStation.append(item.nameStation!)
                forwardSideMeasures.measure.append(item.measurementsToStationForwardSide?.allObjects as! [MeasurementsToStationForwardSide])
                backSideMeasure.nameStation.append(item.nameStation!)
                backSideMeasure.measure.append(item.measurementsToStationBackSide?.allObjects as! [MeasurementsToStationBackSide])
                
            }
        
        } catch  {
            
            print(error)
            
        }
        
       
        
        /// Функция для проверки работоспособнсти свойств и методов класса, заполнения переменных данными.
        func check() {
            
            var itemForForwardMeasure = Int()
            var itemForBackSideMeasure = Int()
            
            print(" ")
            
            for name in forwardSideMeasures.nameStation {
                
                print("Станция: \(name), колличество передних измерений: \(forwardSideMeasures.measure[itemForForwardMeasure].count)")
                
                itemForForwardMeasure += 1
                
            }
            
            print(" ")
            
            for name in backSideMeasure.nameStation {
                
                
                print("Станция: \(name), колличество задних измерений: \(backSideMeasure.measure[itemForBackSideMeasure].count)")
                
                itemForBackSideMeasure += 1
                
            }
            
        }
        
        _ = Angle(backSideMeasure: backSideMeasure, forwardMeasure: forwardSideMeasures)
    
        check()
    }
    
    init(indexPath: IndexPath) {
        
        self.indexPath = indexPath
        
        setup()
        
    }
    
}



