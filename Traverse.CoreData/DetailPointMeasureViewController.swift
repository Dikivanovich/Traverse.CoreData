//
//  DetailPointMeasureViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.06.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData

class DetailPointMeasureViewController: UIViewController {
    
    var willSelectedPoint: Points?
    
    var hZAngle:MeasurementsToPointHz? {
        return willSelectedPoint?.mesureFromStationHz?.anyObject() as? MeasurementsToPointHz
    }
    
    var vAngle: MeasurementsToPointVz? {
        return willSelectedPoint?.mesureFromStationVz?.anyObject() as? MeasurementsToPointVz
    }
    
    let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
    
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
            
            if hZAngle?.distance != kCFNumberNaN && hZAngle?.distance != nil {
                
                return Customisation.instance.returnCurrencyDecimalSeparatorText(value: hZAngle?.distance)
                
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
    
    var vAText: String? {
        
        get {
            
            if vAngle?.degree != nil{
                
                return "\(vAngle!.degree!)˚ " + "\(vAngle!.minutes!)' " + "\(vAngle!.seconds!)\""
                
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
                
                print("\(self.description) Текстовое поле активно")
            }
        }
    }
    
    func keyboardWillHide(){
        for textField in [hZTextField, vATextField, distanceTextField] {
            if textField?.isFirstResponder == true {
                print("\(self.description) Текстовое поле неактивно")
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
        
        Customisation.instance.customozationTextFieldForPicker(textField: hZTextField, placeholder: "Горизонтальный лимб", showSideCircle: true)
        
        Customisation.instance.customozationTextFieldForPicker(textField: vATextField, placeholder: "Вертикальный круг", showSideCircle: false)
        
        Customisation.instance.customozationTextField(textField: xTextField, placeholder: "x", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: yTextField, placeholder: "y", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: zTextField, placeholder: "z", backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        Customisation.instance.customozationTextField(textField: distanceTextField, placeholder: nil, backgroundColor: #colorLiteral(red: 1, green: 0.9776745904, blue: 0.6210460147, alpha: 1))
        
        //MARK:-        Настройка названия navigationItem:
        
        navigationItem.title = "Данные визира"
        navigationItem.prompt = willSelectedPoint?.namePoint
        
        
        //MARK:-        Установка параметров текстовых полей поумолчанию:
        
        namePointTextField.text = willSelectedPoint?.namePoint
        
        hZTextField.text = hZText
        
        vATextField.text = vAText
        
        xTextField.text = xText
        
        yTextField.text = yText
        
        zTextField.text = zText
        
        distanceTextField.text = distanceText
        
        registerForKeyboardNotification()
        
        
        do {
            let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            for station in stations {
                if station.nameStation == willSelectedPoint?.namePoint {
                    
                    print("\(self.description) Точка используетя, как станция")
                    stationOrPointLabel.text = "Станция"
                    stationOrPointLabel.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
                    willSelectedPoint?.nextPicket = true
                    switchStationOrPoint.isOn = true
                    CoreDataManager.instance.saveContext()
                } else {
                    
                    print("\(self.description) Точка не используетя, как станция")
                    stationOrPointLabel.text = "Измеренная точка"
                    stationOrPointLabel.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                    willSelectedPoint?.nextPicket = false
                    switchStationOrPoint.isOn = false
                    CoreDataManager.instance.saveContext()
                    
                }
            }
            
        } catch  {
            print(error)
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
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
//MARK: -        • Проверка изменения имени точки:
        
        if namePointTextField.text == willSelectedPoint?.namePoint {
            
        } else {
            
            willSelectedPoint?.namePoint = namePointTextField.text
            
            print("\(self.description) Блок сохранения имени точки работает")
            
        }
        
//MARK: -        • Проверка координаты "x"
        if xTextField.text == xText {
            
            print("\(self.description) Блок кода сохранения x-координаты не выполняется")
            
        } else {
            willSelectedPoint?.x = Customisation.instance.returnTextAsDecimalNumber(textField: xTextField)
            
            print("\(self.description) Блок сохранения x-координаты точки работает")
        }
        
//MARK: -        •  Проверка координаты "y"
        if yTextField.text == yText {
            
            print("\(self.description) Блок кода сохранения y-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.y = Customisation.instance.returnTextAsDecimalNumber(textField: yTextField)
            
            print("\(self.description) Блок сохранения y-координаты точки работает")
        }
        
//MARK: -        •  Проверка координаты "z"
        if zTextField.text == zText  {
            
            print("\(self.description) Блок кода сохранения z-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.z = Customisation.instance.returnTextAsDecimalNumber(textField: zTextField)
            
            print("\(self.description) Блок сохранения z-координаты точки работает")
        }
        

//MARK: -        • Проверка горизонтального и вертикального угла:
        let hZAngleFromTextField = MeasurementAngle(textField: hZTextField)
        let vAngleFromTextField = MeasurementAngle(textField: vATextField)
        
        
        if hZTextField.text == hZText  {
            
            print("\(self.description) Блок кода сохранениня горизонтального круга не выполняется")
            
        } else {
            
            hZAngle?.degree = hZAngleFromTextField.degree!
            hZAngle?.minutes = hZAngleFromTextField.minutes!
            hZAngle?.seconds = hZAngleFromTextField.seconds!
            
            print("\(self.description) Показания горизонтального круга сохранены")
        }
        
        if vATextField.text! == vAText {
            
            print("\(self.description) Блок кода сохранениня вертикального круга не выполняется")
            
        } else {
            
            vAngle?.degree = vAngleFromTextField.degree as NSObject?
            vAngle?.minutes = vAngleFromTextField.minutes as NSObject?
            vAngle?.seconds = vAngleFromTextField.seconds as NSObject?
            
            print("\(self.description) Показания вертикального круга сохранены")
            
        }
        
//MARK: -        • Проверка горизонтального проложения:
        
        if distanceTextField.text == distanceText {
            
            print("\(self.description) Блок кода сохранения горизонтального проложения не выполняется")
            
        } else {
            
            hZAngle?.distance = Customisation.instance.returnTextAsDecimalNumber(textField: distanceTextField)
            
            print("\(self.description) Блок сохранения горизонтального проложения работает")
        }
        
//MARK: -        • Проверка является ли точка следующей станцией:
        
        willSelectedPoint?.nextPicket = switchStationOrPoint.isOn
        
        
        if switchStationOrPoint.isOn == true {
            
            if xText != "" && yText != "" && zText != "" {
                CoreDataManager.instance.addNewStation(name: (willSelectedPoint?.namePoint)!, x: xText!, y: yText!, z: zText!)
            } else {
                
                CoreDataManager.instance.addNewStation(name: (willSelectedPoint?.namePoint)!)
            }
            
        }
    
        CoreDataManager.instance.saveContext()
        
    }
    
    deinit {
        
        removeKeyboardNotifications()
        print("Экземпляр класса DetailPointMeasureViewController удален из оперативной памяти")
        
    }
    
}
