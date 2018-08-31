//
//  ExtensionsDetailPointMeasureViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 25.08.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension DetailPointMeasureViewController {
    
    func saveChanges() -> Void {
        
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
        
        
        let vAngleFromTextField = VertAngle(textValue: vATextField.text, textDegree: nil)
        let hZAngleFromTextField = HorAngle(verticalAngle: vAngleFromTextField, textValue: hZTextField.text, textDegree: nil)
        
        
        if hZTextField.text! == willSelectedPoint?.measurement?.horizontalAngle?.textValue!  {
            
            print("\n\(self.description) Блок кода сохранениня горизонтального круга не выполняется")
            
        } else {
            
            willSelectedPoint?.measurement?.horizontalAngle?.textValue = hZAngleFromTextField.angleAsText!
            
            print("\n\(self.description) Показания горизонтального круга сохранены, угол равен: \(willSelectedPoint!.measurement!.horizontalAngle!.textValue!)")
        }
        
        if vATextField.text! == willSelectedPoint?.measurement?.verticalAngle?.textValue! {
            
            print("\n\(self.description) Блок кода сохранениня вертикального круга не выполняется")
            
        } else {
            
            willSelectedPoint?.measurement?.verticalAngle?.textValue = vAngleFromTextField.angleAsText!
            
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
            
            var nameStations = [String]()
            
            for station in stations {
                
                nameStations.append(station.nameStation!)
                
                continue
                
            }
            
                if nameStations.contains(willSelectedPoint!.namePoint!) {
                    
                    print("\n\(self.description)Точка есть в списке станций")
                    
                    pointAsStation = true
                    
                } else {
                    
                    print("\n\(self.description)Точки нет в списке станций")
                    
                    pointAsStation = false
                    
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
    
}

extension DetailPointMeasureViewController {
    

    /// - Parameters:
    ///   - textField: Текстовое поле, над которым будет выполнена процедура настройки.
    ///   - placeholder: Текст, который должен указываться в placeholder выбранного текстового поля.
    ///   - backgroundColor: Цвет фона текстового поля.
    func customozationTextField(textField: UITextField, placeholder: String?, backgroundColor: UIColor) {
        
        textField.textAlignment = .center
        textField.leftViewMode = UITextFieldViewMode.always
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        
    }
    
    
    
    
}

extension DetailPointMeasureViewController {
   
    func returnAngles(verticalAngle: VerticalAngle, horizontalAngle: HorizontalAngle) -> (VertAngle, HorAngle) {
    
        let verticalAngle = VertAngle(textValue: verticalAngle.textValue!, textDegree: nil)
        
        let horiazontalAngle = HorAngle(verticalAngle: verticalAngle, textValue: horizontalAngle.textValue!, textDegree: nil)
        
        return (verticalAngle, horiazontalAngle)
        
    }
    
    
    
}

