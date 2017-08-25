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
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
        //MARK: -        • Проверка изменения имени точки:
        
        
        switch namePointTextField.text {
        case willSelectedPoint!.namePoint!?:
            return
        case willSelectedStation?.nameStation!?:
            let alert = UIAlertController.init(title: "Внимание!", message: "Станция не может иметь измерения самой себя ⚠️", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: { (textFieldNamePoint) in
                
                Customisation.instance.customozationTextField(textField: textFieldNamePoint, placeholder: nil, backgroundColor: UIColor.clear)
                textFieldNamePoint.placeholder = "Имя пункта наблюдения"
                
            })
            
            let actionSave = UIAlertAction.init(title: "Сохранить", style: .default, handler: { (alertAction) in
                
                if alert.textFields?[0].text != "" {
                    
                    self.willSelectedPoint?.namePoint = alert.textFields![0].text!
                    
                    CoreDataManager.instance.saveContext()
                    
                    
                    
                } else {
                    
                    
                    
                }
                
            })
            
            let actionCancel = UIAlertAction.init(title: "Отмена", style: .cancel, handler: nil)
            
            alert.addAction(actionSave)
            alert.addAction(actionCancel)
            
            present(alert, animated: true, completion: nil)
            
            
            
        default:
            willSelectedPoint?.namePoint = namePointTextField.text
            
            print("\n\(self.description) Блок сохранения имени точки работает")
            
        }
        
        
        
        //MARK: -        • Проверка координаты "x":
        if xTextField.text == xText {
            
            print("\n\(self.description) Блок кода сохранения x-координаты не выполняется")
            
        } else {
            willSelectedPoint?.x = Customisation.instance.returnTextAsDecimalNumber(textField: xTextField)
            
            print("\n\(self.description) Блок сохранения x-координаты точки работает")
        }
        
        //MARK: -        •  Проверка координаты "y":
        if yTextField.text == yText {
            
            print("\n\(self.description) Блок кода сохранения y-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.y = Customisation.instance.returnTextAsDecimalNumber(textField: yTextField)
            
            print("\n\(self.description) Блок сохранения y-координаты точки работает")
        }
        
        //MARK: -        •  Проверка координаты "z":
        if zTextField.text == zText  {
            
            print("\n\(self.description) Блок кода сохранения z-координаты не выполняется")
            
        } else {
            
            willSelectedPoint?.z = Customisation.instance.returnTextAsDecimalNumber(textField: zTextField)
            
            print("\n\(self.description) Блок сохранения z-координаты точки работает")
        }
        
        
        //MARK: -        • Проверка горизонтального и вертикального угла:
        
        let hZAngleFromTextField = MeasurementAngle(textField: hZTextField)
        let vAngleFromTextField = MeasurementAngle(textField: vATextField)
        
        
        if hZTextField.text! == willSelectedPoint?.measurement?.horizontalAngle?.textValue!  {
            
            print("\n\(self.description) Блок кода сохранениня горизонтального круга не выполняется")
            
        } else {
            
            willSelectedPoint?.measurement?.horizontalAngle?.degree = hZAngleFromTextField.degree!
            willSelectedPoint?.measurement?.horizontalAngle?.minutes = hZAngleFromTextField.minutes!
            willSelectedPoint?.measurement?.horizontalAngle?.seconds = hZAngleFromTextField.seconds!
            willSelectedPoint?.measurement?.horizontalAngle?.textValue = hZAngleFromTextField.textValue
            willSelectedPoint?.measurement?.horizontalAngle?.radianValue = hZAngleFromTextField.radianValue!
            
            
            
            print("\n\(self.description) Показания горизонтального круга сохранены, угол равен: \(willSelectedPoint!.measurement!.horizontalAngle!.textValue!)")
        }
        
        if vATextField.text! == willSelectedPoint?.measurement?.verticalAngle?.textValue! {
            
            print("\n\(self.description) Блок кода сохранениня вертикального круга не выполняется")
            
        } else {
            
            willSelectedPoint?.measurement?.verticalAngle?.degree = vAngleFromTextField.degree!
            willSelectedPoint?.measurement?.verticalAngle?.minutes = vAngleFromTextField.minutes!
            willSelectedPoint?.measurement?.verticalAngle?.seconds = vAngleFromTextField.seconds!
            willSelectedPoint?.measurement?.verticalAngle?.textValue = vAngleFromTextField.textValue
            willSelectedPoint?.measurement?.verticalAngle?.radianValue = vAngleFromTextField.radianValue!
            
            
            print("\n\(self.description) Показания вертикального круга сохранены")
            
        }
        
        //MARK: -        • Проверка горизонтального проложения:
        
        if distanceTextField.text == distanceText {
            
            print("\n\(self.description) Блок кода сохранения горизонтального проложения не выполняется")
            
        } else {
            
            willSelectedPoint?.measurement?.horizontalDistance = Customisation.instance.returnTextAsDecimalNumber(textField: distanceTextField)
            
            print("\n\(self.description) Блок сохранения горизонтального проложения работает")
        }
        
        //MARK: -        • Проверка является ли точка следующей станцией:
        
        
        
        do {
            
            let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            for station in stations {
                
                if station.nameStation! == willSelectedPoint?.namePoint! {
                    
                    print("\n\(self.description)Точка есть в списке станций")
                    
                    pointAsStation = true
                    
                } else {
                    
                    print("\n\(self.description)Точки нет в списке станций")
                    
                    pointAsStation = false
                    
                }
                
            }
            
            if pointAsStation == false { // если точка не обнаружена в списке станций
                
                if switchStationOrPoint.isOn == true { // …и свитч в положении вкл.
                    
                    //MARK:-        • Запись точки в список станций:
                    
                    CoreDataManager.instance.addNewStationFromMeasureList(point: willSelectedPoint!, fromStation: willSelectedStation!)
                    willSelectedPoint?.isStation = true
                    
                }
                
            } else { // если точка обнаружена в списке станций
                
                //MARK:-       • Удаление точки из списка станций:
                if switchStationOrPoint.isOn == false { // …но положение свитча "выкл."
                    willSelectedPoint?.isStation = false
                    let fetchRequestForDelete: NSFetchRequest<Station> = Station.fetchRequest()
                    let predicate = NSPredicate(format: "nameStation == %@", "\(willSelectedPoint!.namePoint!)")
                    fetchRequestForDelete.predicate = predicate
                    
                    do {
                        
                        let stationForDelete = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestForDelete)
                        
                        CoreDataManager.instance.persistentContainer.viewContext.delete(stationForDelete[0])
                        
                        
                    } catch  {
                        
                        print(error)
                        
                    }
                    
                }
                
            }
            
        } catch {
            
            print(error)
            
        }
        
        CoreDataManager.instance.saveContext()
        
    }
    
    deinit {
        
        removeKeyboardNotifications()
        
        print("\n\(self.debugDescription)Экземпляр класса удален из оперативной памяти")
        
    }
    
}
