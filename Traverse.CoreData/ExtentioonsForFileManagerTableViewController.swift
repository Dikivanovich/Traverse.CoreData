//
//  ExtentioonsForViewFileViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 03.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//


import UIKit
import CoreData

extension FileManagerTableViewController {
    
    
    
    /// Функция для парсинга файлов-журналов измерений разных форматов. Пока поддерижвает формат gsi8, gsi16 любого расширения.
    ///
    /// - Parameter textToFormat: Файл журнала измерений прибора.
    /// - Returns: Возвращает текстовое значение названий станций и измеренных точек с этой станци в хронологическом порядке.
    func formatingText(textToFormat: NSString) -> String {
        
        //        MARK:- Properties
        
        var textInView = ""
        
        var nameStation = ""
        
        var namePoint = ""
        
        var hZAngle = ""
        
        var vAngle = ""
        
        var degree = ""
        
        var minutes = ""
        
        var seconds = ""
        
        var slopDistance = ""
        
        var prizmConst = ""
        
        var distance = ""
        
        var x = ""
        
        var y = ""
        
        var z = ""
        
        func returnAngle (basicText: String, searchingText: String) -> String {
            
            let angle = basicText.replacingOccurrences(of: searchingText, with: "")
            
            switch angle.count {
            case 16:
                var someCharacters = angle.dropFirst(8)
                degree = String(someCharacters.dropLast(5))
                someCharacters = angle.dropFirst(11)
                
                minutes = String(someCharacters.dropLast(3))
                seconds = "\(Int(round(Double(String(angle.dropFirst(13)))!/10)))"
                
                return "\(degree)˚ \(minutes)' \(seconds)\""
                
            case 8:
                
                degree = String(angle.dropLast(5))
                minutes = String(angle.dropLast(3))
                minutes = String((minutes).dropFirst(3))
                seconds = "\(Int(round(Double(String(angle.dropFirst(5)))!/10)))"
                return "\(degree)˚ \(minutes)' \(seconds)\""
                
            default:
                
                return ""
                
            }
            
        }
        
        func roundDistance (slopDistance: String, vAngle: String, prizm: String) -> String {
            
            let vAngleDouble = MeasurementAngle(textField: nil, textDegree: vAngle)
            
            var slopeAngle: Double
            
            let positionZeroOfVerticalAngle = Measurement(value: 90.0, unit: UnitAngle.degrees)
            
            let positionZeroOfVerticalAngleInRadians = positionZeroOfVerticalAngle.converted(to: UnitAngle.radians).value
            
            if vAngleDouble.radianValue! > positionZeroOfVerticalAngleInRadians * 2 {
                
                slopeAngle = vAngleDouble.radianValue! - positionZeroOfVerticalAngleInRadians * 3
                
            } else {
                
                slopeAngle = vAngleDouble.radianValue! - positionZeroOfVerticalAngleInRadians
                
            }
            
            let doublePrizm = Double(prizm)!
            
            let doubleSlopDistanceInMillimeters = Double(slopDistance)! * 1000 - doublePrizm
            
            let roundedSlopDistance = round(doubleSlopDistanceInMillimeters)
            
            let cosVerticalAngle = cos(slopeAngle)
            
            let horizontalDistance = round(roundedSlopDistance * cosVerticalAngle)/1000
            
            return String(horizontalDistance)
        }
        
        /// Переменная определяет в какой системе написан файл измерений, аргумент функции textToFormat (8-риной или 16-ричной).
        var searchingTextStation: String {
            
            var text = ""
            
            if textToFormat.contains("*11....") { // В 16-разрядной системе данных
                
               text = "*11...."
                
            } else if textToFormat.contains("41....") { // В 8-разрядной системе данных
                
                text = "41...."
                
            }
            
            return text
        }
        
        var textToFormatAppendingTextStation: String{
            
         var textToFormatAppendingTextStation = textToFormat.replacingOccurrences(of: searchingTextStation, with: "Новая станция \(searchingTextStation)")
            
         textToFormatAppendingTextStation = textToFormatAppendingTextStation.replacingOccurrences(of: "\r\n", with: " ")
            
            return textToFormatAppendingTextStation
            
        }
        
// MARK: - Разбивка журнала измерений на группы измерений с каждой станции.
        
    let textArrayMeasuresToStation = textToFormatAppendingTextStation.components(separatedBy: "Новая станция ") // разбиваем на блоки измерений со станции
        
        for textMeasureInStation in textArrayMeasuresToStation {
            
            if textMeasureInStation != "" {
                
                let separateTextOnGroup = textMeasureInStation.components(separatedBy: " ") // групируем блок измерений со станции и данных самой станци в массив.
                
                for separatedTextOnGroup in separateTextOnGroup {
                    
                    if separatedTextOnGroup != "" {
                        
                        print("\(separatedTextOnGroup)")
                        
// MARK:-           Поиск имени станции и ее координат:
                        
                        if separatedTextOnGroup.hasPrefix("*11....") { // если группа содержит имя станции в 16-й системе данных
                            
                            nameStation = separatedTextOnGroup.replacingOccurrences(of: "*11....+", with: "")
                            nameStation = nameStation.replacingOccurrences(of: "0", with: "")
                            continue
                            
                        } else if separatedTextOnGroup.hasPrefix("42....") { // группа содержит имя станции в 8-й системе данных
  
                            nameStation = separatedTextOnGroup.replacingOccurrences(of: "42....+", with: "")
                            nameStation = nameStation.replacingOccurrences(of: "0", with: "")
                            continue
                            
                        } else if separatedTextOnGroup.hasPrefix("84...6") { // если группа содержит x координату станции
                            
                            x = String(describing: Double(separatedTextOnGroup.replacingOccurrences(of: "84...6", with: ""))!/1000)
                            continue
                            
                        } else if separatedTextOnGroup.hasPrefix("85...6") { // если группа содержит y координату станции
                            
                            y = String(describing: Double(separatedTextOnGroup.replacingOccurrences(of: "85...6", with: ""))!/1000)
                            continue
                            
                        } else if separatedTextOnGroup.hasPrefix("86...6") { // если группа содержит z координату станции
                            
                            z = String(Double(separatedTextOnGroup.replacingOccurrences(of: "86...6", with: ""))!/1000)
                            continue
                        }
                        
                        
                    }
                    
//                    MARK:- Запись данных о станции
                    
                    let fetchRequestSation: NSFetchRequest<Station> = Station.fetchRequest()
                    fetchRequestSation.returnsObjectsAsFaults = false
                    let predicate = NSPredicate(format: "nameStation = %@", nameStation)
                    fetchRequestSation.predicate = predicate
                    
                    do {
                        
                        let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestSation)
                        
                        if stations.isEmpty && nameStation != ""{
                            
                            CoreDataManager.instance.addNewStation(name: nameStation, x: x, y: y, z: z)
                            
                            x = ""
                            y = ""
                            z = ""
                            
                        }
                        
                        
                    } catch  {
                        print(error)
                    }
                    
                    //  MARK:- Поиск измерений со станции:
                    
                    if separatedTextOnGroup.contains("*110") { // поиск группы с кодом имени измерения в 16-й системе
                        
                        namePoint = String(separatedTextOnGroup.dropFirst(12))
                        
                        namePoint = namePoint.replacingOccurrences(of: "0", with: "")
                        
                    } else if separatedTextOnGroup.hasPrefix("110") { // поиск группы с кодом имени изиерения 8-й системе
                        
                        namePoint = String(separatedTextOnGroup.dropFirst(7))
                        
                        namePoint = namePoint.replacingOccurrences(of: "0", with: "")

                    } else if separatedTextOnGroup.hasPrefix("21.024+") { // поиск горизонтального угла с кодом 21.024
                        
                        hZAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "21.024+")
                        
                    } else if separatedTextOnGroup.hasPrefix("21.004+") {
                        
                        hZAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "21.004+")
                        
                    } else if separatedTextOnGroup.hasPrefix("21.324+") {
                        
                        hZAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "21.324+")
                        
                    } else if separatedTextOnGroup.hasPrefix("22.024+") {
                        
                        vAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "22.024+")
                        
                    } else if separatedTextOnGroup.hasPrefix("22.324+") {
                        
                        vAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "22.324+")
                        
                    }  else if separatedTextOnGroup.hasPrefix("22.004+") {
                        
                        vAngle = returnAngle(basicText: separatedTextOnGroup, searchingText: "22.004+")
                        
                    } else if separatedTextOnGroup.hasPrefix("31...6+") {
                        
                        slopDistance = separatedTextOnGroup.replacingOccurrences(of: "31...6+", with: "")
                        
                        slopDistance = String(Double(slopDistance)!/10000)
                        
                    } else if separatedTextOnGroup.hasPrefix("31..00+") {
                        
                        slopDistance = separatedTextOnGroup.replacingOccurrences(of: "31..00+", with: "")
                        
                        slopDistance = String(Double(slopDistance)!/1000)
                        
                        
                        if slopDistance != "0.0" {
                            
                            distance = roundDistance(slopDistance: slopDistance, vAngle: vAngle, prizm: "0.0")
                            
                        } else {
                            
                            distance = slopDistance
                            
                        }
                        
                        let fetchRequestSation: NSFetchRequest<Station> = Station.fetchRequest()
                        fetchRequestSation.returnsObjectsAsFaults = false
                        let predicate = NSPredicate(format: "nameStation = %@", nameStation)
                        fetchRequestSation.predicate = predicate
                        
                        do {
                            let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestSation)
                            for station in stations {
                                
                                if namePoint != "" && hZAngle != "" && vAngle != "" && distance != "" {
                                    
                                    CoreDataManager.instance.addNewMeasure(name: namePoint, x: x, y: y, z: z, fromStation: station, distance: distance, leftCircle: true, hzAngle: MeasurementAngle.init(textField: nil, textDegree: hZAngle), vAngle: MeasurementAngle.init(textField: nil, textDegree: vAngle))
                                    
                                    (namePoint, hZAngle, vAngle, distance) = ("", "", "", "")
                                    
                                }
                            }
                            
                        } catch  {
                            print(error)
                        }

                        
                    } else if separatedTextOnGroup.hasPrefix("51....+") {
                        
                        let separatedConstant = separatedTextOnGroup.replacingOccurrences(of: "51....+", with: "")
                        
                        prizmConst = String(separatedConstant.dropFirst(12))
                        
                        if slopDistance != "0.0" {
                            
                            distance = roundDistance(slopDistance: slopDistance, vAngle: vAngle, prizm: prizmConst)
                            
                        } else {
                            
                            distance = slopDistance
                            
                        }
                        
                        let fetchRequestSation: NSFetchRequest<Station> = Station.fetchRequest()
                        fetchRequestSation.returnsObjectsAsFaults = false
                        let predicate = NSPredicate(format: "nameStation = %@", nameStation)
                        fetchRequestSation.predicate = predicate
                        
                        do {
                            let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestSation)
                            for station in stations {
                                
                                if namePoint != "" && hZAngle != "" && vAngle != "" && distance != "" {
                                    
                                    CoreDataManager.instance.addNewMeasure(name: namePoint, x: x, y: y, z: z, fromStation: station, distance: distance, leftCircle: true, hzAngle: MeasurementAngle.init(textField: nil, textDegree: hZAngle), vAngle: MeasurementAngle.init(textField: nil, textDegree: vAngle))
                                    
                                    (namePoint, hZAngle, vAngle, distance) = ("", "", "", "")
                                    
                                }
                            }
                            
                        } catch  {
                            print(error)
                        }
                        
                    }
                    
                }
                
            }
            
            
            
        }
        
        //        MARK:- Определение является ли точка станцией:
        
        let fetchRequestStation: NSFetchRequest<Station> = Station.fetchRequest()
        let sortDescriptorStation = NSSortDescriptor(key: "dateInitStation", ascending: true)
        fetchRequestStation.sortDescriptors = [sortDescriptorStation]
        fetchRequestStation.returnsObjectsAsFaults = false
        
        let fetchRequestPoint: NSFetchRequest<Point> = Point.fetchRequest()
        let sortDescriptorPoint = NSSortDescriptor(key: "dateInit", ascending: true)
        fetchRequestPoint.sortDescriptors = [sortDescriptorPoint]
        fetchRequestPoint.returnsObjectsAsFaults = false
        
        /// число, отслеживающее количество итераций, для предотваращения повторной записи имен станций в textView
        var n = 0
        
        do {
            let points = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestPoint)
            
            
            let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestStation)
            
            for point in points {
                
                for station in stations {
                    
                    if station.nameStation == point.namePoint { // если имя точки совпадает со станцией
                        
                        point.isStation = true
                        
                        CoreDataManager.instance.saveContext()
                    }
                    
                    if stations.count > n { // запись имен станций в textView:
                        
                        textInView.append("Станция: \(station.nameStation!)\n")
                        
                        n += 1
                        
                        let pointsInStation = station.point?.sortedArray(using: fetchRequestPoint.sortDescriptors!) as! [Point]
                        
                        for pointInStaton in pointsInStation {// запись имен точек, сделанных со станции
                            
                            textInView.append("      - точка: \(pointInStaton.namePoint!)\n")
                            
                        }
                        
                    }
                    
                }
                
            }
            
        } catch  {
            print(error)
        }
        
        return textInView
        
    }
    
}






