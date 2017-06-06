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
    
    @IBOutlet weak var namePointTextField: UITextField!
    
    @IBOutlet weak var hZTextField: UITextField!
    
    @IBOutlet weak var vATextField: UITextField!
    
    @IBOutlet weak var xTextField: UITextField!
    
    @IBOutlet weak var yTextField: UITextField!
    
    @IBOutlet weak var zTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet weak var saveDataButton: UIBarButtonItem!
    
    func saveDataAndUnwind() -> Void {
        
        print("Функция сохранения изменений визира работает")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Настройка названия контроллера:
        
        
        navigationItem.title = "Данные визира"
        navigationItem.prompt = willSelectedPoint?.namePoint
        
        //        Установка параметров текстовых полей поумолчанию:
        namePointTextField.text = willSelectedPoint?.namePoint
        
        let hZAngle = willSelectedPoint?.mesureFromStationHz?.anyObject() as! MeasurementsToPointHz
        let vAngle = willSelectedPoint?.mesureFromStationVz?.anyObject() as? MeasurementsToPointVz
        
        hZTextField.text = "\(hZAngle.degree)˚ " + "\(hZAngle.minutes)' " + "\(hZAngle.seconds)\""
        
        if vAngle != nil{
            vATextField.text = "\(vAngle!.degree)˚ " + "\(vAngle!.minutes)' " + "\(vAngle!.seconds)\""
        }
        
        customozationTextFieldForPicker(textField: hZTextField, placeholder: "Горизонтальный лимб", showSideCircle: true)
        
        customozationTextFieldForPicker(textField: vATextField, placeholder: "Вертикальный круг", showSideCircle: false)
        
        customozationTextField(textField: xTextField, placeholder: nil)
        
        customozationTextField(textField: yTextField, placeholder: nil)
        
        customozationTextField(textField: zTextField, placeholder: nil)
        
        customozationTextField(textField: distanceTextField, placeholder: nil)
        
        
        if willSelectedPoint?.x != nil && willSelectedPoint?.y != nil && willSelectedPoint?.z != nil && hZAngle.distance != nil {
            
            xTextField.text = String(describing: willSelectedPoint!.x!)
            yTextField.text = String(describing: willSelectedPoint!.y!)
            zTextField.text = String(describing: willSelectedPoint!.z!)
            distanceTextField.text = String(describing: hZAngle.distance!)
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        hZTextField.resignFirstResponder()
        vATextField.resignFirstResponder()
        xTextField.resignFirstResponder()
        yTextField.resignFirstResponder()
        zTextField.resignFirstResponder()
        
    }
    
    deinit {
        print("Экземпляр класса DetailPointMeasureViewController удален из оперативной памяти")
    }

}
