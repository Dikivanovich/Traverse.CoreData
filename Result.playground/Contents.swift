//: Playground - noun: a place where people can play

import UIKit
import CoreData

class MeasurementAngle {
    
    private var textField: UITextField?
    var degree: Int16?
    var minutes: Int16?
    var seconds: Int16?
    var textValue: String?
    var radianValue: NSDecimalNumber?
    
    private func setup() {
        
        if textField?.text != "" && textField?.text != nil {
            var textAngle = textField?.text!
            let replacingText: [String] = ["˚", "'", "\""]
            for item in replacingText {
                textAngle = textAngle?.replacingOccurrences(of: item, with: "")
            }
            let splityngText: [String.CharacterView] = textAngle!.characters.split(separator: " ")
            let degreeText = String(splityngText[0])
            let minutesText = String(splityngText[1])
            let secondsText = String(splityngText[2])
            
            degree = Int16(degreeText)!
            minutes = Int16(minutesText)!
            seconds = Int16(secondsText)!
            textValue = "\(degree!)˚ " + "\(minutes!)' " + "\(seconds!)\""
            radianValue = NSDecimalNumber(value: Double(degree!) + Double(minutes!)/60 + Double(seconds!)/60)
            
            
            
            print("Текстовое поле не пустое, выполнена установка значений измеренного угла")
        } else {
            
            print("Текстовое поле пустое")
            degree = nil
            minutes = nil
            seconds = nil
            textValue = nil
            radianValue = nil
        }
        
        
    }
    init(textField: UITextField?) {
        self.textField = textField
        setup()
    }
    
    deinit {
        print("Класс MeasurementAngle выгружен из оператвной памяти")
    }
    
}


class CurrentData {
    
    static let instance = CurrentData()
    
    
    func returnDate() -> String
    {
        let date = NSDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormater.string(from: date as Date)
        return dateString
    }
    
    private init() {}
}



extension MeasurementsToStationBackSide {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToStationBackSide> {
        return NSFetchRequest<MeasurementsToStationBackSide>(entityName: "MeasurementsToStationBackSide")
    }
    
    @NSManaged public var degree: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?
    
}



@objc(MeasurementsToStationBackSide)
public class MeasurementsToStationBackSide: NSManagedObject {
    
}



extension MeasurementsToStationForwardSide {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToStationForwardSide> {
        return NSFetchRequest<MeasurementsToStationForwardSide>(entityName: "MeasurementsToStationForwardSide")
    }
    
    @NSManaged public var degree: Int16
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var station: Station?
    
}




@objc(MeasurementsToStationForwardSide)
public class MeasurementsToStationForwardSide: NSManagedObject {
    
}



extension Points {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Points> {
        return NSFetchRequest<Points>(entityName: "Points")
    }
    
    @NSManaged public var dateMeasure: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var namePoint: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var nextPicket: Bool
    @NSManaged public var mesureFromStationHz: NSSet?
    @NSManaged public var mesureFromStationVz: NSSet?
    @NSManaged public var station: Station?
    
}

// MARK: Generated accessors for mesureFromStationHz
extension Points {
    
    @objc(addMesureFromStationHzObject:)
    @NSManaged public func addToMesureFromStationHz(_ value: MeasurementsToPointHz)
    
    @objc(removeMesureFromStationHzObject:)
    @NSManaged public func removeFromMesureFromStationHz(_ value: MeasurementsToPointHz)
    
    @objc(addMesureFromStationHz:)
    @NSManaged public func addToMesureFromStationHz(_ values: NSSet)
    
    @objc(removeMesureFromStationHz:)
    @NSManaged public func removeFromMesureFromStationHz(_ values: NSSet)
    
}

// MARK: Generated accessors for mesureFromStationVz
extension Points {
    
    @objc(addMesureFromStationVzObject:)
    @NSManaged public func addToMesureFromStationVz(_ value: MeasurementsToPointVz)
    
    @objc(removeMesureFromStationVzObject:)
    @NSManaged public func removeFromMesureFromStationVz(_ value: MeasurementsToPointVz)
    
    @objc(addMesureFromStationVz:)
    @NSManaged public func addToMesureFromStationVz(_ values: NSSet)
    
    @objc(removeMesureFromStationVz:)
    @NSManaged public func removeFromMesureFromStationVz(_ values: NSSet)
    
}


@objc(Points)
public class Points: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Points"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }
    
}


extension MeasurementsToPointHz {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPointHz> {
        return NSFetchRequest<MeasurementsToPointHz>(entityName: "MeasurementsToPointHz")
    }
    
    @NSManaged public var degree: Int16
    @NSManaged public var distance: NSDecimalNumber?
    @NSManaged public var leftSide: Bool
    @NSManaged public var minutes: Int16
    @NSManaged public var seconds: Int16
    @NSManaged public var point: Points?
    @NSManaged public var station: Station?
    
}



@objc(MeasurementsToPointHz)
public class MeasurementsToPointHz: NSManagedObject {
    
}


@objc(MeasurementsToPointVz)
public class MeasurementsToPointVz: NSManagedObject {
    
}


extension MeasurementsToPointVz {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MeasurementsToPointVz> {
        return NSFetchRequest<MeasurementsToPointVz>(entityName: "MeasurementsToPointVz")
    }
    
    @NSManaged public var degree: NSObject?
    @NSManaged public var minutes: NSObject?
    @NSManaged public var seconds: NSObject?
    @NSManaged public var point: Points?
    @NSManaged public var station: Station?
    
}


extension Station {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Station> {
        return NSFetchRequest<Station>(entityName: "Station")
    }
    
    @NSManaged public var dateInitStation: String?
    @NSManaged public var fixed: Bool
    @NSManaged public var nameStation: String?
    @NSManaged public var x: NSDecimalNumber?
    @NSManaged public var y: NSDecimalNumber?
    @NSManaged public var z: NSDecimalNumber?
    @NSManaged public var measurementsToPointHz: NSSet?
    @NSManaged public var measurementsToPointVz: NSSet?
    @NSManaged public var measurementsToStationBackSide: NSSet?
    @NSManaged public var measurementsToStationForwardSide: NSSet?
    @NSManaged public var point: NSSet?
    
}

// MARK: Generated accessors for measurementsToPointHz
extension Station {
    
    @objc(addMeasurementsToPointHzObject:)
    @NSManaged public func addToMeasurementsToPointHz(_ value: MeasurementsToPointHz)
    
    @objc(removeMeasurementsToPointHzObject:)
    @NSManaged public func removeFromMeasurementsToPointHz(_ value: MeasurementsToPointHz)
    
    @objc(addMeasurementsToPointHz:)
    @NSManaged public func addToMeasurementsToPointHz(_ values: NSSet)
    
    @objc(removeMeasurementsToPointHz:)
    @NSManaged public func removeFromMeasurementsToPointHz(_ values: NSSet)
    
}

// MARK: Generated accessors for measurementsToPointVz
extension Station {
    
    @objc(addMeasurementsToPointVzObject:)
    @NSManaged public func addToMeasurementsToPointVz(_ value: MeasurementsToPointVz)
    
    @objc(removeMeasurementsToPointVzObject:)
    @NSManaged public func removeFromMeasurementsToPointVz(_ value: MeasurementsToPointVz)
    
    @objc(addMeasurementsToPointVz:)
    @NSManaged public func addToMeasurementsToPointVz(_ values: NSSet)
    
    @objc(removeMeasurementsToPointVz:)
    @NSManaged public func removeFromMeasurementsToPointVz(_ values: NSSet)
    
}

// MARK: Generated accessors for measurementsToStationBackSide
extension Station {
    
    @objc(addMeasurementsToStationBackSideObject:)
    @NSManaged public func addToMeasurementsToStationBackSide(_ value: MeasurementsToStationBackSide)
    
    @objc(removeMeasurementsToStationBackSideObject:)
    @NSManaged public func removeFromMeasurementsToStationBackSide(_ value: MeasurementsToStationBackSide)
    
    @objc(addMeasurementsToStationBackSide:)
    @NSManaged public func addToMeasurementsToStationBackSide(_ values: NSSet)
    
    @objc(removeMeasurementsToStationBackSide:)
    @NSManaged public func removeFromMeasurementsToStationBackSide(_ values: NSSet)
    
}

// MARK: Generated accessors for measurementsToStationForwardSide
extension Station {
    
    @objc(addMeasurementsToStationForwardSideObject:)
    @NSManaged public func addToMeasurementsToStationForwardSide(_ value: MeasurementsToStationForwardSide)
    
    @objc(removeMeasurementsToStationForwardSideObject:)
    @NSManaged public func removeFromMeasurementsToStationForwardSide(_ value: MeasurementsToStationForwardSide)
    
    @objc(addMeasurementsToStationForwardSide:)
    @NSManaged public func addToMeasurementsToStationForwardSide(_ values: NSSet)
    
    @objc(removeMeasurementsToStationForwardSide:)
    @NSManaged public func removeFromMeasurementsToStationForwardSide(_ values: NSSet)
    
}

// MARK: Generated accessors for point
extension Station {
    
    @objc(addPointObject:)
    @NSManaged public func addToPoint(_ value: Points)
    
    @objc(removePointObject:)
    @NSManaged public func removeFromPoint(_ value: Points)
    
    @objc(addPoint:)
    @NSManaged public func addToPoint(_ values: NSSet)
    
    @objc(removePoint:)
    @NSManaged public func removeFromPoint(_ values: NSSet)
    
}


@objc(Station)
public class Station: NSManagedObject {
    
    convenience init() {
        
        self.init(entity: CoreDataManager.instance.entityForNAme(entityName: "Station"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
        
    }
    
}





class CoreDataManager {
    
    //    Singleton
    
    static let instance = CoreDataManager()
    
    private init() {}
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Traverse_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func entityForNAme(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.instance.persistentContainer.viewContext)!
    }
    
    
    
    //    MARK: - Создание контроллера данных:
    
    func returnFetchedResultsControllerStation() -> NSFetchedResultsController<Station>  {
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        let sortDescriptorNameStation = NSSortDescriptor(key: "dateInitStation", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptorNameStation]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchRequest.returnsObjectsAsFaults = false
        
        return fetchedResultsController
        
        
    }
    
    //    MARK: - Добавление новой фиксированной станции:
    
    func addNewStation(name nameStation: String, x: String, y: String, z: String) {
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Station", into: CoreDataManager.instance.persistentContainer.viewContext) as! Station
        
        managedObject.nameStation = nameStation
        managedObject.dateInitStation = CurrentData.instance.returnDate()
        managedObject.fixed = true
        managedObject.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?
        managedObject.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?
        managedObject.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?
        
        CoreDataManager.instance.saveContext()
        
        print("Станция добавлена, теперь список станций такой:")
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        
        
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in results as [Station] {
                var fixedSt = String()
                if result.fixed == true {
                    fixedSt = "Фиксированная"
                    
                } else {
                    
                    fixedSt = "Вычисляемая"
                    
                    
                }
                
                print("Станция: \(result.nameStation!), категория: \(fixedSt)")
                
            }
            
        } catch  {
            
            print(error)
        }
        
        
    }
    
    
    //    MARK: - Добавление новой вычисляемой станции:
    
    func addNewStation(name nameStation: String) {
        
        
        
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Station", into: CoreDataManager.instance.persistentContainer.viewContext) as! Station
        
        managedObject.nameStation = nameStation
        managedObject.dateInitStation = CurrentData.instance.returnDate()
        managedObject.fixed = false
        
        CoreDataManager.instance.saveContext()
        
        print("Станция добавлена, теперь список станций такой:")
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        
        do {
            
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            for result in results as [Station] {
                
                var fixedSt = String()
                
                if result.fixed == true {
                    
                    fixedSt = "Фиксированная"
                    
                } else {
                    
                    fixedSt = "Вычисляемая"
                    
                }
                
                print("Станция: \(result.nameStation!), категория: \(fixedSt)")
                
            }
            
        } catch  {
            
            print(error)
            
        }
    }
    
    
    
    //    MARK: - Добавление новой фиксированной точки:
    
    func addNewMeasure (name namePoint: String, x: String, y: String, z: String, fromStation: Station,  distance: String, hzAngle: MeasurementAngle, vAngle: MeasurementAngle?) {
        
        
        let managedObjectPoints:Points = NSEntityDescription.insertNewObject(forEntityName: "Points", into: CoreDataManager.instance.persistentContainer.viewContext) as! Points
        
        managedObjectPoints.dateMeasure = CurrentData.instance.returnDate()
        managedObjectPoints.namePoint = namePoint
        managedObjectPoints.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?
        managedObjectPoints.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?
        managedObjectPoints.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?
        managedObjectPoints.fixed = true
        
        let managedObjectMeasurementsToPointHz: MeasurementsToPointHz = NSEntityDescription.insertNewObject(forEntityName: "MeasurementsToPointHz", into: CoreDataManager.instance.persistentContainer.viewContext) as! MeasurementsToPointHz
        
        let managedObjectMeasurementsToPointVz: MeasurementsToPointVz = NSEntityDescription.insertNewObject(forEntityName: "MeasurementsToPointVz", into: CoreDataManager.instance.persistentContainer.viewContext) as! MeasurementsToPointVz
        
        managedObjectMeasurementsToPointHz.degree = hzAngle.degree!
        managedObjectMeasurementsToPointHz.minutes = hzAngle.minutes!
        managedObjectMeasurementsToPointHz.seconds = hzAngle.seconds!
        managedObjectMeasurementsToPointHz.distance = NumberFormatter().number(from: distance)?.decimalValue as NSDecimalNumber?
        
        
        managedObjectMeasurementsToPointVz.degree = vAngle?.degree as NSObject?
        managedObjectMeasurementsToPointVz.minutes = vAngle?.minutes  as NSObject?
        managedObjectMeasurementsToPointVz.seconds = vAngle?.seconds as NSObject?
        managedObjectPoints.addToMesureFromStationVz(managedObjectMeasurementsToPointVz)
        fromStation.addToMeasurementsToPointVz(managedObjectMeasurementsToPointVz)
        
        
        
        
        
        //    добавление связи точки со станцией:
        
        managedObjectPoints.addToMesureFromStationHz(managedObjectMeasurementsToPointHz)
        fromStation.addToPoint(managedObjectPoints)
        fromStation.addToMeasurementsToPointHz(managedObjectMeasurementsToPointHz)
        
        CoreDataManager.instance.saveContext()
        
    }
    
    //    MARK: - Добавление новой вычисляемой точки наблюдения:
    
    /// Данная функция создает запись сущности Points с атрибутами x, y, z равными nil, добавляет дату записи точки, статус вычисляемого положения станции, а так же добавляет связь к сущности Station at IndexPath
    ///
    /// - Parameters:
    ///   - namePoint: String - Имя точки присваивается атрибуту экземпляра сущности Points
    ///   - fromStation: Station - Станция, выбранная из списка по IndexPath
    func addNewMeasure (name namePoint: String, fromStation: Station, distance: String, hzAngle: MeasurementAngle, vAngle: MeasurementAngle?) {
        
        let managedPoints:Points = NSEntityDescription.insertNewObject(forEntityName: "Points", into: CoreDataManager.instance.persistentContainer.viewContext) as! Points
        
        let managedMeasurementsToPointHz: MeasurementsToPointHz = NSEntityDescription.insertNewObject(forEntityName: "MeasurementsToPointHz", into: CoreDataManager.instance.persistentContainer.viewContext) as! MeasurementsToPointHz
        
        let managedMeasurementsToPointVa: MeasurementsToPointVz = NSEntityDescription.insertNewObject(forEntityName: "MeasurementsToPointVz", into: CoreDataManager.instance.persistentContainer.viewContext) as! MeasurementsToPointVz
        
        managedPoints.dateMeasure = CurrentData.instance.returnDate()
        managedPoints.namePoint = namePoint
        managedPoints.fixed = false
        
        managedMeasurementsToPointHz.degree = hzAngle.degree!
        managedMeasurementsToPointHz.minutes = hzAngle.minutes!
        managedMeasurementsToPointHz.seconds = hzAngle.seconds!
        managedMeasurementsToPointHz.distance = NumberFormatter().number(from: distance)?.decimalValue as NSDecimalNumber?
        
        
        managedMeasurementsToPointVa.degree = vAngle?.degree as NSObject?
        managedMeasurementsToPointVa.minutes = vAngle?.minutes as NSObject?
        managedMeasurementsToPointVa.seconds = vAngle?.seconds as NSObject?
        managedPoints.addToMesureFromStationVz(managedMeasurementsToPointVa)
        fromStation.addToMeasurementsToPointVz(managedMeasurementsToPointVa)
        
        
        //    добавление связи точки со станцией, измерения со станции и измерения на точку:
        managedPoints.addToMesureFromStationHz(managedMeasurementsToPointHz)
        fromStation.addToPoint(managedPoints)
        fromStation.addToMeasurementsToPointHz(managedMeasurementsToPointHz)
        
        CoreDataManager.instance.saveContext()
        
    }
    
}


