
//
//  Extensions.swift
//  Traverse.CoreData
//
//  Created by Dik on 24.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension MeasurementsListViewController {
    
    func checkingStatusPoint() {
        
        var points = [Point]()
        
        var stations = [Station]()
        
        var nameStations = [String]()
        
        let fetchRequestPoint: NSFetchRequest<Point> = Point.fetchRequest()
        
        do {
            
            points = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestPoint)
            
        } catch  {
            
            print(error)
            
        }
        
        let fetchRequestStation: NSFetchRequest<Station> = Station.fetchRequest()
        
        do {
            
            stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestStation)
            
        } catch  {
            
            print(error)
            
        }
        
        for point in points {
            
            for station in stations {
                
                nameStations.append(station.nameStation!)
                
                continue
                
            }
            
            if nameStations.contains(point.namePoint!) {
                
                point.isStation = true
                
            } else {
                
                point.isStation = false
                
            }

            
        }
        
 
        
        
    }
    
    
    
}

// MARK: - Расширение для у даления наблюдателей и inputView's из текстовых полей.
extension MeasurementsListViewController {
    
    /// Функция при вызове удаляет наблюдатели действия переключателя Switch, а так же обращает inputView's текстовых полей в nil, что бы освободить инициализируемые классы (предотвращение утечки памяти).
    ///
    /// - Parameter textFields: Аргументом функции служат текстовые поля UIAlertController'а. Их можно вызвать, используя свойство класса (UIAlertController.textFields)
    func alertControllerWillDisappear(textFields: [UITextField]?) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: "leftCircleTrue"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.init(rawValue: "leftCircleFalse"), object: nil)
        
        for textField in textFields! {
            
            textField.inputView = nil
            
        }
    }
    
    
}

// MARK: - Расширение для сохранения известной точки
extension MeasurementsListViewController {
    
    

    /// Функция сохраняет точку в модель базы данных, по условию, из AlertController'а
    ///
    /// - Parameters:
    ///   - alertNamePoint: Контроллер, в котором введено в текстовое поле имя измеренной точки.
    ///   - alertController: Контроллер, в котором непосредственно вводятся данные об измеренной точки.
    func savePoint(alertNamePoint: UIAlertController , alertController: UIAlertController)  {
        if  alertController.textFields?[0].text! != "" && alertController.textFields?[1].text! != "" && alertController.textFields?[2].text! != "" && alertController.textFields?[3].text! != "" && alertController.textFields?[4].text! != "" &&
            alertController.textFields?[5].text! != "" {
            
            let angleHz = MeasurementAngle(textField: (alertController.textFields?[3])!)
            let angleVz = MeasurementAngle(textField: (alertController.textFields?[4])!)
            
            CoreDataManager.instance.addNewMeasure(name: alertNamePoint.textFields!.first!.text!, x: alertController.textFields![0].text! , y: alertController.textFields![1].text!, z: alertController.textFields![2].text!, fromStation: self.didSelectedStation!,distance: alertController.textFields![5].text!, leftCircle: self.leftCircle, hzAngle: angleHz, vAngle: angleVz)
            self.tableView.reloadData()
            self.alertControllerWillDisappear(textFields: alertController.textFields)
        } else {
            
            
            let alertError = UIAlertController.init(title: "Ошибка!", message: "Введите координаты пункта наблюдения!", preferredStyle: UIAlertControllerStyle.alert)
            
            let alertErrorAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.present(alertController, animated: true, completion: nil)
            })
            
            alertError.addAction(alertErrorAction)
            
            self.present(alertError, animated: true, completion: nil)
            
        }

    }
    
}

// MARK: - Расширение для сохранения вычисляемой точки:
extension MeasurementsListViewController {
    
    /// Функция сохраняет в базу данных вычисляемую точку
    ///
    /// - Parameters:
    ///   - generalAlertController: Контроллер с именем точки.
    ///   - alertController: Контроллер со значениями точки.
    func savePoint(generalAlertController: UIAlertController , alertController: UIAlertController) {
        
        if alertController.textFields?[0].text != "" && alertController.textFields?[1].text != "" && alertController.textFields?[2].text != ""  {
            
            let hzAngle = MeasurementAngle(textField: (alertController.textFields?[0])!)
            let vAngle = MeasurementAngle(textField: (alertController.textFields?[1])!)
            
            CoreDataManager.instance.addNewMeasure(name: generalAlertController.textFields!.first!.text!, x: nil, y: nil, z: nil, fromStation: self.didSelectedStation!,distance: alertController.textFields![2].text!, leftCircle: self.leftCircle , hzAngle: hzAngle, vAngle: vAngle)
            self.tableView.reloadData()
            self.alertControllerWillDisappear(textFields: alertController.textFields)
        } else if alertController.textFields?[0].text != "" && alertController.textFields?[1].text == "" && alertController.textFields?[2].text != "" {
            
            let hzAngle = MeasurementAngle(textField: (alertController.textFields?[0])!)
            CoreDataManager.instance.addNewMeasure(name: generalAlertController.textFields!.first!.text!, x: nil, y: nil, z: nil, fromStation: self.didSelectedStation!, distance: alertController.textFields![2].text!, leftCircle: self.leftCircle, hzAngle: hzAngle, vAngle: nil)
            self.tableView.reloadData()
            self.alertControllerWillDisappear(textFields: alertController.textFields)
            
        } else {
            
            let alertError = UIAlertController.init(title: "Ошибка!", message: "Поле отчета по горизонтальному лимбу должно быть обязательно заполнено!", preferredStyle: UIAlertControllerStyle.alert)
            
            let alertErrorAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.present(alertController, animated: true, completion: nil)
            })
            
            alertError.addAction(alertErrorAction)
            
            self.present(alertError, animated: true, completion: nil)
            
        }

        
        
    }
    
}



