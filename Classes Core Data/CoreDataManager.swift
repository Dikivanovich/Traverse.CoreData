import UIKitimport CoreDataclass CoreDataManager {    //    Singleton        static let instance = CoreDataManager()         private init() {}        // MARK: - Core Data stack        lazy var persistentContainer: NSPersistentContainer = {        /*         The persistent container for the application. This implementation         creates and returns a container, having loaded the store for the         application to it. This property is optional since there are legitimate         error conditions that could cause the creation of the store to fail.         */        let container = NSPersistentContainer(name: "Traverse_CoreData")        container.loadPersistentStores(completionHandler: { (storeDescription, error) in            if let error = error as NSError? {                // Replace this implementation with code to handle the error appropriately.                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.                                /*                 Typical reasons for an error here include:                 * The parent directory does not exist, cannot be created, or disallows writing.                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.                 * The device is out of space.                 * The store could not be migrated to the current model version.                 Check the error message to determine what the actual problem was.                 */                fatalError("Unresolved error \(error), \(error.userInfo)")            }        })        return container    }()        // MARK: - Core Data Saving support       func saveContext () {        let context = self.persistentContainer.viewContext        if context.hasChanges {            do {                try context.save()            } catch {                // Replace this implementation with code to handle the error appropriately.                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.                let nserror = error as NSError                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")            }        }    }            func entityForNAme(entityName: String) -> NSEntityDescription {        return NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.instance.persistentContainer.viewContext)!    }         //    MARK: - Создание контроллера данных:        func returnFetchedResultsControllerStation() -> NSFetchedResultsController<Station>  {        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()    let sortDescriptorNameStation = NSSortDescriptor(key: "dateInitStation", ascending: true)    fetchRequest.sortDescriptors = [sortDescriptorNameStation]    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)    fetchRequest.returnsObjectsAsFaults = false        return fetchedResultsController            }    //    MARK: - Добавление новой фиксированной станции:        func addNewStation(name nameStation: String, x: String, y: String, z: String) {    let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Station", into: CoreDataManager.instance.persistentContainer.viewContext) as! Station        managedObject.nameStation = nameStation    managedObject.dateInitStation = CurrentData.instance.returnDate()    managedObject.fixed = true        managedObject.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?        managedObject.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?        managedObject.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?        CoreDataManager.instance.saveContext()        print("Станция добавлена, теперь список станций такой:")        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()            do {            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)                        for result in results as [Station] {            var fixedSt = String()                    if result.fixed == true {                    fixedSt = "Фиксированная"                                    } else {                                        fixedSt = "Вычисляемая"                                                            }                        print("Станция: \(result.nameStation!), категория: \(fixedSt)")                        }                    } catch  {                        print(error)    }            }        //    MARK: - Добавление новой вычисляемой станции:        func addNewStation(name nameStation: String) {                                let managedObject = NSEntityDescription.insertNewObject(forEntityName: "Station", into: CoreDataManager.instance.persistentContainer.viewContext) as! Station                        managedObject.nameStation = nameStation            managedObject.dateInitStation = CurrentData.instance.returnDate()            managedObject.fixed = false                        CoreDataManager.instance.saveContext()                        print("Станция добавлена, теперь список станций такой:")                        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()                        do {            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)                for result in results as [Station] {        var fixedSt = String()        if result.fixed == true {            fixedSt = "Фиксированная"            } else {                fixedSt = "Вычисляемая"            }        print("Станция: \(result.nameStation!), категория: \(fixedSt)")            }            } catch  {            print(error)                }    }            //    MARK: - Добавление новой фиксированной точки:          func addNewMeasure (name namePoint: String, x: String, y: String, z: String, fromStation: Station) {            let managedObjectPoints:Points = NSEntityDescription.insertNewObject(forEntityName: "Points", into: CoreDataManager.instance.persistentContainer.viewContext) as! Points        managedObjectPoints.dateMeasure = CurrentData.instance.returnDate()    managedObjectPoints.namePoint = namePoint    managedObjectPoints.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?    managedObjectPoints.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?    managedObjectPoints.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?    managedObjectPoints.fixed = true    //    добавление связи точки со станцией        fromStation.addToPoint(managedObjectPoints)       CoreDataManager.instance.saveContext()     }     //    MARK: - Добавление новой вычисляемой точки наблюдения:        /// Данная функция создает запись сущности Points с атрибутами x, y, z равными nil, добавляет дату записи точки, статус вычисляемого положения станции, а так же добавляет связь к сущности Station at IndexPath    ///    /// - Parameters:    ///   - namePoint: String - Имя точки присваивается атрибуту экземпляра сущности Points    ///   - fromStation: Station - Станция, выбранная из списка по IndexPath    func addNewMeasure (name namePoint: String, fromStation: Station, hzAngle: (degree: Int16, minutes: Int16, seconds: Int16)?) {        let managedObjectPoints:Points = NSEntityDescription.insertNewObject(forEntityName: "Points", into: CoreDataManager.instance.persistentContainer.viewContext) as! Points        let managedObjectMeasurementsToPoint: MeasurementsToPointHz = NSEntityDescription.insertNewObject(forEntityName: "MeasurementsToPointHz", into: CoreDataManager.instance.persistentContainer.viewContext) as! MeasurementsToPointHz        managedObjectPoints.dateMeasure = CurrentData.instance.returnDate()    managedObjectPoints.namePoint = namePoint    managedObjectPoints.fixed = false    if hzAngle != nil {    managedObjectMeasurementsToPoint.degree = (hzAngle?.degree)!    managedObjectMeasurementsToPoint.minutes = (hzAngle?.minutes)!    managedObjectMeasurementsToPoint.seconds = (hzAngle?.seconds)!    } else {        }        //    добавление связи точки со станцией, измерения со станции и измерения на точку:    managedObjectPoints.addToMesureFromStation(managedObjectMeasurementsToPoint)    fromStation.addToPoint(managedObjectPoints)    fromStation.addToMeasurementsToPoint(managedObjectMeasurementsToPoint)        CoreDataManager.instance.saveContext()                }    }