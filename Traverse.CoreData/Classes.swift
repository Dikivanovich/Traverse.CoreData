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
    
    @IBOutlet weak var namePointLabel: UILabel!
    
    @IBOutlet weak var verticalCirclePositionLabel: UILabel!
    
    @IBOutlet weak var fixedPositionLabel: UILabel!
    
    @IBOutlet weak var dataInitLabel: UILabel!
    
    
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
        textField.textAlignment = .center
        textField.leftViewMode = UITextFieldViewMode.always
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        
        
        
        if placeholder != nil {
            textField.placeholder = "координата \(placeholder!)"
            let leftImageView = UIImageView()
            leftImageView.layer.cornerRadius = 5
            leftImageView.clipsToBounds = true
            
            
            switch placeholder! {
            case "x":
                leftImageView.image = #imageLiteral(resourceName: "Xcopy.png")
            case "y":
                leftImageView.image = #imageLiteral(resourceName: "Ycopy.png")
            case "z":
                leftImageView.image = #imageLiteral(resourceName: "Zcopy.png")
            default:
                break
            }
            
            leftImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            
            textField.leftView = leftImageView
            
        } else {
            
            textField.placeholder = "Горизонтальное проложение"
        }
        
        
        
    }
    
    /// Данная функция реализует Custom Picker View, вместо стандартной клавиатуры, для указанного в аргументе текстового поля.
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
    var radianValue: Double?
    
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
            radianValue = Double(degree!) + Double(minutes!)/60 + Double(seconds!)/60
            
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

class ResultMeasure {
    
    var viewController: UIViewController!
    
    var indexPath: IndexPath?
    
    var stations = [Station]()
    
    var measurements = [Measurement]()
    
    var points = [Point]()
    
    var horizontalAngles = [HorizontalAngle]()
    
    var verticalAngles = [VerticalAngle]()
    
    var angles = (left: [Double](), right: [Double]())
    
    var distances = (left: [NSNumber](), right: [NSNumber]())
    
    var forwardMeasures = (leftCircle: [Double](), rightCircle: [Double]())
    
    var backSideMeasures = (leftCircle: [Double](), rightCircle: [Double]())
    
    func setup() {
        
        let fetchRequestPoints:NSFetchRequest<Point> = Point.fetchRequest()
        let predicate = NSPredicate(format: "isStation == %@", "1")
        fetchRequestPoints.returnsObjectsAsFaults = false
        fetchRequestPoints.predicate = predicate
        
        do {
            points = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestPoints)
            
        } catch  {
            print(error)
        }
        
        let fetchRequest: NSFetchRequest = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let dateDescription = NSSortDescriptor(key: "dateInitStation", ascending: true)
        
        do {
            
            stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            for station in stations {
                
                let pts = station.point?.allObjects as! [Point]
                
                for point in pts {
                    
                    if point.isStation == true { // точка является станцией
                        
                        if point.measurement?.horizontalAngle?.leftCircle == true { //измерение при КЛ
                            
                            angles.left.append(point.measurement!.horizontalAngle!.radianValue)
                            
                            distances.left.append(point.measurement!.horizontalDistance!)
                            
                        } else { // измерение при КП
                            
                            angles.right.append(point.measurement!.horizontalAngle!.radianValue)
                            
                            distances.right.append(point.measurement!.horizontalDistance!)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } catch  {
            
            print(error)
            
        }
        
        differenceAngle(forAngles: &angles.left, viewController: viewController)
        differenceAngle(forAngles: &angles.right, viewController: viewController)
        
        let fetchRequestMeasure: NSFetchRequest<Measurement> = Measurement.fetchRequest()
        fetchRequestMeasure.returnsObjectsAsFaults = false
        do {
            measurements = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestMeasure)
            
        } catch  {
            print(error)
        }
        
        
        let fetchRequestHorizontalAngle: NSFetchRequest<HorizontalAngle> = HorizontalAngle.fetchRequest()
        fetchRequestHorizontalAngle.returnsObjectsAsFaults = false
        
        do {
            
            horizontalAngles = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestHorizontalAngle)
            
        } catch  {
            
            print(error)
            
        }
        
        let fetchRequestVerticalAngle: NSFetchRequest<VerticalAngle> = VerticalAngle.fetchRequest()
        fetchRequestVerticalAngle.returnsObjectsAsFaults = false
        
        do {
            verticalAngles = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestVerticalAngle)
        } catch  {
            print(error)
        }
        
        
        
        
        /// Функция для проверки работоспособнсти свойств и методов класса, заполнения переменных данными.
        func check() {
            
            print("\nСписок станций:\(stations)")
            print("\nСписок измерений: \(measurements)")
            print("\nСписок точек: \(points)")
            print("\nСписок горизонтальрых углов: \(horizontalAngles)")
            print("\nСписок вертикальных углов: \(verticalAngles)")
            print("\nСписок прямых измерений: \(forwardMeasures) \nСписок обратных измерений: \(backSideMeasures)")
            print("\nСписок левых и правых углов: \(angles)")
            
        }
        
        check()
    }
    
    init(indexPath: IndexPath, viewController: UIViewController) {
        
        self.indexPath = indexPath
        self.viewController = viewController
        
        setup()
        
    }
    
}



