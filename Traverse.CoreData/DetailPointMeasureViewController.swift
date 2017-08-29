//
//  DetailPointMeasureViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 25.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData

class DetailPointMeasureViewController: UIViewController {
    
    let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
    
    var pointAsStation = Bool()
    
    var willSelectedStation: Station?
    
    var willSelectedPoint: Point?
    
    var indexPathSelectedPoint: IndexPath?


    var xText: String? {
        
        get{
            
            if willSelectedPoint?.x != kCFNumberNaN && willSelectedPoint?.x != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.x!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var yText: String? {
        
        get {
            
            if willSelectedPoint?.y != kCFNumberNaN && willSelectedPoint?.y != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.y!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var zText: String? {
        
        get {
            
            if willSelectedPoint?.z != kCFNumberNaN && willSelectedPoint?.z != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: willSelectedPoint!.z!)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    var distanceText: String? {
        
        get {
            
            if willSelectedPoint?.measurement?.horizontalDistance != kCFNumberNaN && willSelectedPoint?.measurement?.horizontalDistance != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: willSelectedPoint?.measurement?.horizontalDistance)
                
            } else {
                
                return ""
                
            }
            
        }
        
    }
    
    
    func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(notification: Notification){
        
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        for textField in [hZTextField, vATextField, distanceTextField] {
            if textField?.isFirstResponder == true {
                scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
                
                print("\n\(self.description) Текстовое поле активно")
            }
        }
    }
    
    func keyboardWillHide(){
        for textField in [hZTextField, vATextField, distanceTextField] {
            if textField?.isFirstResponder == true {
                print("\n\(self.description) Текстовое поле неактивно")
                scrollView.contentOffset = CGPoint.zero
                
            }
        }
    }
    
    func removeKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @IBOutlet weak var namePointTextField: UITextField!
    
    @IBOutlet weak var hZTextField: UITextField!
    
    @IBOutlet weak var vATextField: UITextField!
    
    @IBOutlet weak var xTextField: UITextField!
    
    @IBOutlet weak var yTextField: UITextField!
    
    @IBOutlet weak var zTextField: UITextField!
    
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var stationOrPointLabel: UILabel!
    
    @IBOutlet weak var switchStationOrPoint: UISwitch!
    
    @IBAction func switchStationOrPointAction(_ sender: Any) {
        
        //MARK:-        Реализация статуса измерения (станция или точка):
        
        if switchStationOrPoint.isOn == false {
            
            stationOrPointLabel.text = "Измеренная точка"
            stationOrPointLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            
        } else {
            
            stationOrPointLabel.text = "Станция"
            stationOrPointLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:-        Настройка inputView для текстовых полей:
        
        _ = Customisation.instance.customozationTextFieldForPicker(textField: hZTextField, placeholder: "Горизонтальный лимб", showSideCircle: true)
        
        _ = Customisation.instance.customozationTextFieldForPicker(textField: vATextField, placeholder: "Вертикальный круг", showSideCircle: false)
        
        Customisation.instance.customozationTextField(textField: xTextField, placeholder: "x", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: yTextField, placeholder: "y", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: zTextField, placeholder: "z", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: distanceTextField, placeholder: nil, backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        //MARK:-        Настройка названия navigationItem:
        
        navigationItem.title = "Данные визира"
        
        navigationItem.prompt = willSelectedPoint?.namePoint
        
        
        //MARK:-        Установка параметров текстовых полей поумолчанию:
        
        namePointTextField.text = willSelectedPoint?.namePoint
        
        hZTextField.text = willSelectedPoint?.measurement?.horizontalAngle?.textValue
        
        vATextField.text = willSelectedPoint?.measurement?.verticalAngle?.textValue
        
        xTextField.text = xText
        
        yTextField.text = yText
        
        zTextField.text = zText
        
        distanceTextField.text = distanceText
        
        registerForKeyboardNotification()
        
        
        if willSelectedPoint!.isStation == true {
            
            print("\n\(self.description) Точка используетя, как станция\n")
            stationOrPointLabel.text = "Станция"
            stationOrPointLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            switchStationOrPoint.isOn = true
            
            
        } else {
            
            print("\n\(self.description) Точка не используетя, как станция\n")
            stationOrPointLabel.text = "Измеренная точка"
            stationOrPointLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            switchStationOrPoint.isOn = false
            
            
        }
        
        
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
    //MARK: Реализация нажатия кнопки "Save":
    
    @IBAction func saveChangesAction(_ sender: Any) {
        
        
        //MARK: -        • Проверка изменения имени точки:
        
        
        switch namePointTextField.text! {
            
        case willSelectedPoint!.namePoint!: //текстовое поле осталось без изменений
            
            saveChanges()
            
            self.performSegue(withIdentifier: "unwindFromDetailPointVC", sender: self)
            
            
            
        case willSelectedStation!.nameStation!: // текстовое поле соотвествует имени станции
      
                let alert = UIAlertController.init(title: "Внимание!", message: "Станция не может иметь измерения самой себя ⚠️", preferredStyle: .alert)
                
                alert.addTextField(configurationHandler: { (textFieldNamePoint) in
                    
                    self.customozationTextField(textField: textFieldNamePoint, placeholder: nil, backgroundColor: UIColor.clear)
                    textFieldNamePoint.placeholder = "Имя пункта наблюдения"
                    
                })
                
                let actionSave = UIAlertAction.init(title: "Сохранить", style: .default, handler: { (alertAction) in
                    
                    if alert.textFields?[0].text != "" && alert.textFields?[0].text != self.willSelectedStation?.nameStation {
                        
                        self.willSelectedPoint?.namePoint = alert.textFields![0].text!
                        
                        CoreDataManager.instance.saveContext()
                        
                        self.saveChanges()
                        
                        self.performSegue(withIdentifier: "unwindFromDetailPointVC", sender: self)
                        
                    }
                    
                })
                
                let actionCancel = UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)
                
                alert.addAction(actionSave)
                alert.addAction(actionCancel)
                
                self.present(alert, animated: true, completion: nil)
            
                for textField in alert.textFields! {
                    
                    let container = textField.superview
                    let effectView = container?.superview?.subviews[0]
                    if (effectView != nil) {
                        
                        container?.backgroundColor = UIColor.clear
                        effectView?.removeFromSuperview()
                        
                    }
                    
            }

            
            
        case "":
            
            let alert = UIAlertController.init(title: "Внимание!", message: "Поле имени измерения не может быть пустым ⚠️", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { (textFieldNamePoint) in
                
                self.customozationTextField(textField: textFieldNamePoint, placeholder: nil, backgroundColor: UIColor.clear)
                textFieldNamePoint.placeholder = "Имя пункта наблюдения"
                
            })
            
            let actionSave = UIAlertAction.init(title: "Сохранить", style: .default, handler: { (alertAction) in
                
                if alert.textFields?[0].text != "" && alert.textFields?[0].text != self.willSelectedStation?.nameStation {
                    
                    self.willSelectedPoint?.namePoint = alert.textFields![0].text!
                    
                    CoreDataManager.instance.saveContext()
                    
                    self.saveChanges()
                    
                    self.performSegue(withIdentifier: "unwindFromDetailPointVC", sender: self)
                    
                }
                
            })
            
            let actionCancel = UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(actionSave)
            alert.addAction(actionCancel)
            
            self.present(alert, animated: true, completion: nil)
            
            for textField in alert.textFields! {
                
                let container = textField.superview
                let effectView = container?.superview?.subviews[0]
                if (effectView != nil) {
                    
                    container?.backgroundColor = UIColor.clear
                    effectView?.removeFromSuperview()
                    
                }
                
            }

            
        default:
            willSelectedPoint?.namePoint = namePointTextField.text
            
            print("\n\(self.description) Блок сохранения имени точки работает")
            
            saveChanges()
            
            self.performSegue(withIdentifier: "unwindFromDetailPointVC", sender: self)
        }
        
        
        
    }


    deinit {
        
        removeKeyboardNotifications()
        
        print("\n\(String(describing: self))Экземпляр класса удален из оперативной памяти")
        
        
        
    }
    

}
