//
//  DetailStationViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 28.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData

class DetailStationViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    var editableStation: Station?
    
    var xText: String? {
        
        get{
            if editableStation?.x != nil {
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: editableStation!.x!)
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var yText: String? {
        
        get{
            if editableStation?.y != nil {
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: editableStation!.y!)
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var zText: String? {
        
        get{
            if editableStation?.z != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: editableStation!.z!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }

    @IBOutlet weak var nameStationTextField: UITextField!
    
    @IBOutlet weak var textFieldStationX: UITextField!
    
    @IBOutlet weak var textFieldStationY: UITextField!
    
    @IBOutlet weak var textFieldStationZ: UITextField!
    
    @IBAction func saveData(_ sender: Any) {
        
        if  nameStationTextField.text == editableStation!.nameStation! {
            
        } else {
            
            editableStation?.nameStation = nameStationTextField.text
            CoreDataManager.instance.saveContext()
        }
        
        if textFieldStationX.text == xText {
            
        } else {
            
            editableStation?.x = Customisation.instance.returnTextAsDecimalNumber(textField: textFieldStationX)
            CoreDataManager.instance.saveContext()
        }
        
        if textFieldStationY.text == yText {
            
        } else {
            
            editableStation?.y = Customisation.instance.returnTextAsDecimalNumber(textField: textFieldStationY)
            CoreDataManager.instance.saveContext()
        }
        
        if textFieldStationZ.text == zText {
            
        } else {
            
            editableStation?.z = Customisation.instance.returnTextAsDecimalNumber(textField: textFieldStationZ)
            CoreDataManager.instance.saveContext()
        }
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

// настройка отображения названия редактируемой станции:
        navigationItem.title = editableStation!.nameStation!

//        настройка текстового поля для редактирования имени станции:
        nameStationTextField.text = editableStation!.nameStation!
        nameStationTextField.resignFirstResponder()
        
//            заполнение тектовых полей коориднатами станции (опционально):
        textFieldStationX.text = xText
        textFieldStationY.text = yText
        textFieldStationZ.text = zText
        
//     MARK: -   настройка текстовых полей для редактирования координат станции (опциаонально):
        
        Customisation.instance.customozationTextField(textField: textFieldStationX, placeholder: "x", backgroundColor: UIColor.clear)
        Customisation.instance.customozationTextField(textField: textFieldStationY, placeholder: "y", backgroundColor: UIColor.clear)
        Customisation.instance.customozationTextField(textField: textFieldStationZ, placeholder: "z", backgroundColor: UIColor.clear)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        let textFields = [textFieldStationX, textFieldStationY, textFieldStationZ]
        
        for textField in textFields {
            textField?.inputView = nil
        }
        
        print("Функция viewWillDisappear DetailStationViewController выполнена")
        
    }


}
