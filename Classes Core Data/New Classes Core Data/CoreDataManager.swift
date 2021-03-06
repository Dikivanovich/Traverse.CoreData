
import UIKit
import CoreData

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
    
    //    MARK:- Создание сущности для записи данных:
    
    func entityForNAme(entityName: String) -> NSEntityDescription {
    return NSEntityDescription.entity(forEntityName: entityName, in: CoreDataManager.instance.persistentContainer.viewContext)!
    }
    
    //    MARK: - Создание контроллера данных для станции:
    
    func returnFetchedResultsControllerStation() -> NSFetchedResultsController<Station>  {
    
    let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
    let sortDescriptorNameStation = NSSortDescriptor(key: "dateInitStation", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptorNameStation]
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchRequest.returnsObjectsAsFaults = false
    
    return fetchedResultsController
    
    }
    
    //    MARK: - Создание контроллера данных для точки:
    
    func returnFetchedResultsControllerPoint() -> NSFetchedResultsController<Point>  {
    
    let fetchRequest: NSFetchRequest<Point> = Point.fetchRequest()
    let sortDescriptorNameStation = NSSortDescriptor(key: "dateInit", ascending: true)
    fetchRequest.sortDescriptors = [sortDescriptorNameStation]
    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchRequest.returnsObjectsAsFaults = false
    
    return fetchedResultsController
    
    }
    
    
    //    MARK: - Добавление новой станции:
    
    func addNewStation(name nameStation: String, x: String, y: String, z: String) {
    
    let station = Station()
    
    station.nameStation = nameStation //установка имени инициализируемой станции
    
    //    MARK: • Инициализация и установка формата даты
    let dateInitStation = NSDate() //инициализация даты
    
    station.dateInitStation = dateInitStation //установка даты инициализации даты станции
    
    let coordinate = [x, y, z]
    
    if coordinate.contains("")  {
    
    station.fixed = false
    
    station.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?
    station.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?
    station.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?
    
} else {
    
    station.fixed = true
    station.x = NumberFormatter().number(from: x)?.decimalValue as NSDecimalNumber?
    station.y = NumberFormatter().number(from: y)?.decimalValue as NSDecimalNumber?
    station.z = NumberFormatter().number(from: z)?.decimalValue as NSDecimalNumber?
    
    
    
    }
    
    
    CoreDataManager.instance.saveContext()
    
    print("\n\(self)Станция добавлена, теперь список станций такой:")
    
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
    
    
    //MARK: - Добавление новой станции из журнала измерений:
    
    func addNewStationFromMeasureList (point selectedPoint: Point, fromStation: Station) {
    
    //MARK:   • Инициализация станции, заполнение переменных:
    
    let station: Station = Station()
    
    //    MARK: • Инициализация и установка формата даты
    let dateInitStation = NSDate() //инициализация даты
    let dateFormater = DateFormatter() //инициализация формата даты
    dateFormater.dateFormat = "MM-dd-yyyy HH:mm" //установка формата даты
    
    station.nameStation = selectedPoint.namePoint!  // имя станции
    station.dateInitStation = dateInitStation  // время создания записи
    
    //    Проверка наличия координат точки при создании станции:
    if selectedPoint.x != nil && selectedPoint.y != nil && selectedPoint.z != nil {
    
    station.fixed = true
    
    station.x = selectedPoint.x
    station.y = selectedPoint.y
    station.z = selectedPoint.z
    
} else {
    
    station.fixed = false
    
    }
    
    
    CoreDataManager.instance.saveContext()
    
    print("\n\(self)Станция добавлена, теперь список станций такой:")
    
    let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
    
    do {
    let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
    
    for stationFetch in stations as [Station] {
    var fixedSt = String()
    if stationFetch.fixed == true {
    
    fixedSt = "Фиксированная"
    
} else {
    
    fixedSt = "Вычисляемая"
    
    }
    
    print("Станция: \(stationFetch.nameStation!), категория: \(fixedSt)")
    
    }
    
} catch  {
    
    print(error)
    
    }
    }
    
    //    MARK: - Добавление новой точки:
    
    func addNewMeasure (name namePoint: String, x: String?, y: String?, z: String?, fromStation: Station,  distance: String, leftCircle: Bool , hzAngle: MeasurementAngle, vAngle: MeasurementAngle?) {
    
    //    MARK:  • Инициализация постоянных управляемых объектов модели данных (Point, Measurement, Angle, Station)
    let point: Point = Point()
    let measure: Measure = Measure()
    let horizontalAngle: HorizontalAngle = HorizontalAngle()
    let verticalAngle: VerticalAngle = VerticalAngle()
    
    //    MARK: • Инициализация и установка формата даты
    let dateInitMeasure = NSDate() //инициализация даты
    let dateFormater = DateFormatter() //инициализация формата даты
    dateFormater.dateFormat = "MM-dd-yyyy HH:mm" //установка формата даты
    point.dateInit = dateInitMeasure //установка значения даты инициализации точки
    
    //    MARK: • Установка имени точки
    point.namePoint = namePoint //установка значения имени точки
    
    //    MARK: • Определение состояния точки (вычисляемая или известная), установка значений переменных x, y, z
    if x != nil && x! != "" && y != nil && y! != "" && z != nil && z! != "" {
    point.x = NumberFormatter().number(from: x!)?.decimalValue as NSDecimalNumber?
    point.y = NumberFormatter().number(from: y!)?.decimalValue as NSDecimalNumber?
    point.z = NumberFormatter().number(from: z!)?.decimalValue as NSDecimalNumber?
    point.fixed = true
} else {
    point.x = nil
    point.y = nil
    point.z = nil
    point.fixed = false
    }
    
    //    MARK: • Добавление горизонтального проложения в измерение, определение прямого и обратного измерения
    
    measure.horizontalDistance = NumberFormatter().number(from: distance)?.decimalValue as NSDecimalNumber?
    
    //     MARK: • Добавление отчета по горизонтальному лимбу
    horizontalAngle.textValue = hzAngle.textValue
    //     MARK: • Добавление отчета по вертикальному кругу
    if vAngle != nil {
    verticalAngle.textValue = vAngle?.textValue
    measure.verticalAngle = verticalAngle
    
    //    MARK:  • Добавление связи точки со станцией измерением:
    measure.horizontalAngle = horizontalAngle
    
    measure.point = point
    measure.station = fromStation
    fromStation.addToPoint(point)
    
        
    
    CoreDataManager.instance.saveContext()
    
        }
    
    }

}
