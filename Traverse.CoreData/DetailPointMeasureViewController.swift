//
//  DetailPointMeasureViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.06.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit

class DetailPointMeasureViewController: UIViewController {
    
    
    
    var willSelectedPoint: Points?
    
    var hZAngle:MeasurementsToPointHz? {
        
        get {
            
            return willSelectedPoint?.mesureFromStationHz?.anyObject() as? MeasurementsToPointHz
            
        }
        
    }

    
    var xText: String? {
        
        get{
            
            if willSelectedPoint?.x != kCFNumberNaN && willSelectedPoint?.x != nil {
                
                return returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.x!)
                
            } else {
                
                return ""
                
            }
            
        }
        
        
    }
    
    var yText: String? {
        
        get {
            
            if willSelectedPoint?.y != kCFNumberNaN && willSelectedPoint?.y != nil {
                
                return returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.y!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var zText: String? {
        
        get {
            
            if willSelectedPoint?.z != kCFNumberNaN && willSelectedPoint?.z != nil {
                
                return returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.z!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var distanceText: String? {
        
        get {
            
             if hZAngle?.distance != kCFNumberNaN && hZAngle?.distance != nil {
                
                return returnCurrencyDecimalSeparatorText(value: hZAngle?.distance)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var hZText: String? {
        
        get {
            
            if hZAngle?.degree != nil{
                
                return "\(hZAngle!.degree)˚ " + "\(hZAngle!.minutes)' " + "\(hZAngle!.seconds)\""
                
            } else {
                
                return ""
            }
            
            
        }
        
        
    }
    
    @IBOutlet weak var namePointTextField: UITextField!
    
    @IBOutlet weak var hZTextField: UITextField!
    
    @IBOutlet weak var vATextField: UITextField!
    
    @IBOutlet weak var xTextField: UITextField!
    
    @IBOutlet weak var yTextField: UITextField!
    
    @IBOutlet weak var zTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBAction func saveDataButton(_ sender: Any) {
        
        if namePointTextField.text == willSelectedPoint?.namePoint {
            
        } else {
            
            willSelectedPoint?.namePoint = namePointTextField.text
            CoreDataManager.instance.saveContext()
            print("Блок сохранения имени точки работает")
            
        }
        
        if xTextField.text == xText {
            
            print("Блок кода сохранения x-координаты не выполняется")
            
        } else {
            willSelectedPoint?.x = returnTextAsDecimalNumber(textField: xTextField)
            CoreDataManager.instance.saveContext()
            print("Блок сохранения x-координаты точки работает")
        }
        
        if yTextField.text == yText {
            
            print("Блок кода сохранения y-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.y = returnTextAsDecimalNumber(textField: yTextField)
            CoreDataManager.instance.saveContext()
            print("Блок сохранения y-координаты точки работает")
        }
        
        if zTextField.text == zText  {
            
            print("Блок кода сохранения z-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.z = returnTextAsDecimalNumber(textField: zTextField)
            CoreDataManager.instance.saveContext()
            print("Блок сохранения z-координаты точки работает")
        }
        
        
        let hZAngleFromTextField = returnAngleFromTextField(textField: hZTextField)
        let vAngle = willSelectedPoint?.mesureFromStationVz?.anyObject() as? MeasurementsToPointVz
        let vAngleFromTextField = returnAngleFromTextField(textField: vATextField)
        
        
        if hZTextField.text == hZText  {
            
           print("блок сохранениня горизонтального круга не работает")
            
        } else {
            
            hZAngle?.degree = hZAngleFromTextField!.degree
            hZAngle?.minutes = hZAngleFromTextField!.minutes
            hZAngle?.seconds = hZAngleFromTextField!.seconds
            CoreDataManager.instance.saveContext()
        }
        
        if vATextField.text == "\(vAngle!.degree)˚ " + "\(vAngle!.minutes)' " + "\(vAngle!.seconds)\"" {
            
            print("блок сохранениня вертикального круга не работает")
            
        } else {
            
            vAngle?.degree = vAngleFromTextField!.degree
            vAngle?.minutes = vAngleFromTextField!.minutes
            vAngle?.seconds = vAngleFromTextField!.seconds
            CoreDataManager.instance.saveContext()
            
        }
        
        if distanceTextField.text == distanceText {
            
            print("Блок кода сохранения горизонтального проложения не выполняется")
            
        } else {
            
            hZAngle?.distance = returnTextAsDecimalNumber(textField: distanceTextField)
            CoreDataManager.instance.saveContext()
            print("Блок сохранения горизонтального проложения работает")
        }
        
        print("функция сохранения данных работает")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customozationTextFieldForPicker(textField: hZTextField, placeholder: "Горизонтальный лимб", showSideCircle: true)
        
        customozationTextFieldForPicker(textField: vATextField, placeholder: "Вертикальный круг", showSideCircle: false)
        
        customozationTextField(textField: xTextField, placeholder: nil)
        
        customozationTextField(textField: yTextField, placeholder: nil)
        
        customozationTextField(textField: zTextField, placeholder: nil)
        
        customozationTextField(textField: distanceTextField, placeholder: nil)

        //        Настройка названия контроллера:
        navigationItem.title = "Данные визира"
        navigationItem.prompt = willSelectedPoint?.namePoint
        
        //        Установка параметров текстовых полей поумолчанию:
        
        namePointTextField.text = willSelectedPoint?.namePoint
        
        
        let vAngle = willSelectedPoint?.mesureFromStationVz?.anyObject() as? MeasurementsToPointVz
        
       
        
        hZTextField.text = hZText
        
        if vAngle != nil{
            
            vATextField.text = "\(vAngle!.degree)˚ " + "\(vAngle!.minutes)' " + "\(vAngle!.seconds)\""
            
        }
        
        xTextField.text = xText
        
        yTextField.text = yText
        
        zTextField.text = zText
            
        distanceTextField.text = distanceText
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        namePointTextField.resignFirstResponder()
        hZTextField.resignFirstResponder()
        vATextField.resignFirstResponder()
        xTextField.resignFirstResponder()
        yTextField.resignFirstResponder()
        zTextField.resignFirstResponder()
        distanceTextField.resignFirstResponder()
        
    }
    
    deinit {
        
        print("Экземпляр класса DetailPointMeasureViewController удален из оперативной памяти")
        
    }
    
}
