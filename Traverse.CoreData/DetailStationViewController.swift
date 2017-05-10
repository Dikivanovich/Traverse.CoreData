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
                return String(describing: editableStation!.x!)
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var yText: String? {
        
        get{
            if editableStation?.y != nil {
                return String(describing: editableStation!.y!)
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var zText: String? {
        
        get{
            if editableStation?.z != nil {
                return String(describing: editableStation!.z!)
                
                
            } else {
                
                return ""
                
            }
            
        }
        
    }


    
    @IBOutlet weak var nameStation: UILabel!

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
            
            editableStation?.x = NumberFormatter().number(from: textFieldStationX.text!)?.decimalValue as NSDecimalNumber?
            CoreDataManager.instance.saveContext()
        }
        
        if textFieldStationY.text == yText {
            
        } else {
            
            editableStation?.y = NumberFormatter().number(from: textFieldStationY.text!)?.decimalValue as NSDecimalNumber?
            CoreDataManager.instance.saveContext()
        }
        
        if textFieldStationZ.text == zText {
            
        } else {
            
            editableStation?.z = NumberFormatter().number(from: textFieldStationZ.text!)?.decimalValue as NSDecimalNumber?
            CoreDataManager.instance.saveContext()
        }
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

// настройка отображения названия редактируемой станции:
        nameStation.text = editableStation!.nameStation!

//        настройка текстового поля для редактирования имени станции:
        nameStationTextField.text = editableStation!.nameStation!
        nameStationTextField.resignFirstResponder()
        
//            заполнение тектовых полей коориднатами станции (опционально):
        textFieldStationX.text = xText
        textFieldStationY.text = yText
        textFieldStationZ.text = zText
        
        
        
        
//     MARK: -   настройка текстовых полей для редактирования координат станции (опциаонально):
        
        let coordinateTextFields = [textFieldStationX, textFieldStationY, textFieldStationZ]
        
        for field in coordinateTextFields {
            
//            подгрузка кастомной клавиатуры:
            
            field?.inputView = MyCustomKeyboard.init().loadFromNib()
            
//            заполнение placeholder'ов, если текстовое поле пустое:
            
            if field?.text == "" {
                field?.placeholder = "Вычисляемое значение"
            }

            
                    }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
