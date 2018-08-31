//
//  StationsTableViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 03.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData

class StationsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate    {
    
    var station: Station?
    
    var selectedAtIndexPath: IndexPath?
    
    var indexPathForResultAction: IndexPath?
    
    
    let fetchedResultController = CoreDataManager.instance.returnFetchedResultsControllerStation()
    
    func customozationTextField(textField: UITextField, placeholder: String) {
        
        textField.inputView = MyCustomKeyboard.init().loadFromNib()
        textField.placeholder = "координата \(placeholder)"
        textField.textAlignment = .center
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.repeatCount = 1
        textField.backgroundColor = UIColor.clear
        textField.layer.cornerRadius = 5
        textField.leftViewMode = UITextFieldViewMode.always
        
        let leftImageView = UIImageView()
        leftImageView.layer.cornerRadius = 5
        leftImageView.clipsToBounds = true
        
        switch placeholder {
        case "x":
            leftImageView.image = #imageLiteral(resourceName: "Xcopy.png")
        case "y":
            leftImageView.image = #imageLiteral(resourceName: "Ycopy.png")
        case "z":
            leftImageView.image = #imageLiteral(resourceName: "Zcopy.png")
        default:
            break
        }
        leftImageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        
        textField.leftView = leftImageView
        
    }
    
    @IBAction func unwindToDetailStationVC (sender: UIStoryboardSegue) {
    }
    

    @IBAction func addNewStationAction(_ sender: Any) {
        
        
        //  MARK: - Создание запроса на ввод имени станции
        let alert = UIAlertController.init(title: "Добавьте станцию", message: "Введите в текстовое поле имя вашей новой станции", preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "Название"} // добавление текстового поля в запрос на созданине станции
        
        //        MARK: - Релизация кнопки "Добавить":
        let alertActionAdd = UIAlertAction.init(title: "Добавить", style: UIAlertActionStyle.default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
                let alertFixedOrNotStation = UIAlertController.init(title: "Категория положения станции", message: "Является ли положение станции фиксированным", preferredStyle: .actionSheet)
                
                let alertActionFixedStation = UIAlertAction.init(title: "Да", style: .default, handler: { (alertAction) in
                    
                    let alertInputCoordinateController = UIAlertController.init(title: "Координаты станции", message: "Введите координаты станции", preferredStyle: .alert)
                    
                    //  MARK: -  Настройка текстовых полей для ввода координат:
                    
                    alertInputCoordinateController.addTextField(configurationHandler: {  (textFieldX)  in
                        
                        self.customozationTextField(textField: textFieldX, placeholder: "x")
                    })
                    
                    
                    alertInputCoordinateController.addTextField(configurationHandler: { (textFieldY) in
                        
                        self.customozationTextField(textField: textFieldY, placeholder: "y")
                    })
                    
                    alertInputCoordinateController.addTextField(configurationHandler: { (textFieldZ) in
                        
                        self.customozationTextField(textField: textFieldZ, placeholder: "z")
                        
                    })
                    
                    let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: {  (alertAction) in
                        
                        if  alertInputCoordinateController.textFields?[0].text! != "" && alertInputCoordinateController.textFields?[1].text! != "" && alertInputCoordinateController.textFields?[2].text! != "" {
                            
                            CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, x: alertInputCoordinateController.textFields![0].text!, y: alertInputCoordinateController.textFields![1].text!, z: alertInputCoordinateController.textFields![2].text!)
                            self.tableView.reloadData()
                        } else {
                            
                            
                            let alertError = UIAlertController.init(title: "Ошибка!", message: "Введите координаты станции для последующего сохранения", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let alertErrorAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                                self.present(alertInputCoordinateController, animated: true, completion: nil)
                            })
                            
                            alertError.addAction(alertErrorAction)
                            
                            self.present(alertError, animated: true, completion: nil)
                            
                        }
                        
                    })
                    
                    let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
                        print("push cancel")
                        
                    }
                    
                    alertInputCoordinateController.addAction(alertAddCoordinatAction)
                    alertInputCoordinateController.addAction(alertActionCancel)
                    self.present(alertInputCoordinateController, animated: true, completion: nil)
                    
                    
                    for textField in alertInputCoordinateController.textFields! {
                        
                        let container = textField.superview
                        let effectView = container?.superview?.subviews[0]
                        if (effectView != nil) {
                            
                            container?.backgroundColor = UIColor.clear
                            effectView?.removeFromSuperview()
                            
                        }
                        
                        
                    }
                    
                    
                    
                })
                
                let alertActionNotFixedStation = UIAlertAction.init(title: "Нет", style: UIAlertActionStyle.default, handler: { (alertAction) in
                    
                    CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, x: "", y: "", z: "")
                    self.tableView.reloadData()
                    
                })
                
                alertFixedOrNotStation.addAction(alertActionFixedStation)
                alertFixedOrNotStation.addAction(alertActionNotFixedStation)
                
                self.present(alertFixedOrNotStation, animated: true, completion: nil)
                
                
            }
            
        }
        
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
            print("push cancel")
            
        }
        
        
        
        
        
        
        alert.addAction(alertActionAdd)
        alert.addAction(alertActionCancel)
        
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    @IBOutlet weak var resultButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Делегат
        
        fetchedResultController.delegate = self
        
        
        
        
        // MARK: - Настройка вида TableView
        
        title = "Станции"
        
        self.tableView.backgroundColor = UIColor.gray
        self.tableView.separatorColor = UIColor.magenta
        
        
        
        do {
            try fetchedResultController.performFetch()
        } catch  {
            let err = error as NSError
            print(err.userInfo)
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let stations = fetchedResultController.fetchedObjects else {
            
            return 0
        }
        
        if stations.count == 0 {
            
            resultButton.isEnabled = false
            
        } else {
            
            resultButton.isEnabled = true
            
        }
        
        return stations.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        indexPathForResultAction = indexPath
        
        //     Configure the cell...
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)/* as! CustomCell */
        cell.detailTextLabel?.numberOfLines = 3
        cell.selectionStyle = .blue
        
        
        
        
        let station = fetchedResultController.object(at: indexPath)
        
        
        cell.textLabel?.text = station.nameStation
        cell.textLabel?.textAlignment = .center
        
        
        if station.fixed == true {
            cell.backgroundColor = UIColor.orange
            cell.detailTextLabel?.text = "Дата установки станции: \(station.returnStringDate())\nФиксированная"
            
        } else {
            
            cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            cell.detailTextLabel?.text = "Дата установки станции: \(station.returnStringDate())\nВычисляемая"
            
            
        }
        
        return cell
    }
    
    // Реализация swipe для доступа к дополнительным опциям:
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction.init(style: .destructive, title: "Удалить") { (_, indexPath) in
            // Delete the row from the data source
            
            let station = self.fetchedResultController.object(at: indexPath)
            CoreDataManager.instance.persistentContainer.viewContext.delete(station)
            
            CoreDataManager.instance.saveContext()
            //            Если котроллер не подписан на делегат, то надо добавть строку:
            //            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
            
        }
        
        let viewInfoAction = UITableViewRowAction.init(style: .normal, title: "info") { (action, indexPath) in
            
            
            
            self.station = self.fetchedResultController.object(at: indexPath)
            
            self.performSegue(withIdentifier: "ShowDetailStation", sender: self.station)
            
            
        }
        
        viewInfoAction.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        
        
        return [deleteAction, viewInfoAction]
        
        
    }
    
    // MARK: - Navigation
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath)  -> IndexPath? {
        
        print("\nвыбрана строка №: \(indexPath.row + 1)")
        
        station = fetchedResultController.object(at: indexPath)
        selectedAtIndexPath = indexPath
        return indexPath
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "ShowMeasurements" {
            
            (segue.destination as! MeasurementsListViewController).didSelectedStation = station
            
            
        }
        
        if segue.identifier == "ShowDetailStation" {
            
            (segue.destination as! DetailStationViewController).editableStation = sender as? Station
            
        }
        
        
    }
    
    //    MARK: - Отслеживание изменения данных в таблице через делегат (NSFetchedResultController):
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        print("таблица редактируется")
        tableView.beginUpdates()
        
        
    }
    
    //        если нужно отслеживать разбивку таблицы по секциям:
    
    /*
     func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
     switch type {
     case .insert:
     tableView.insertSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
     tableView.reloadData()
     case .delete:
     tableView.deleteSections(NSIndexSet(index: sectionIndex) as IndexSet, with: .fade)
     tableView.reloadData()
     default:
     return
     }
     }
     */
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
                
            }
        case .update:
            if let indexPath = indexPath {
                print("Функия именования ячейки работает")
                let station = fetchedResultController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)! as! CustomCell
                
                cell.detailTextLabel?.numberOfLines = 3
                cell.textLabel?.text = station.nameStation
                
                if station.fixed == true {
                    cell.backgroundColor = UIColor.orange
                    cell.detailTextLabel?.text = "Дата установки станции: \(station.returnStringDate())\nФиксированная"
                    
                } else {
                    
                    cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                    cell.detailTextLabel?.text = "Дата установки станции: \(station.returnStringDate())\nВычисляемая"
                    
                }
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        case .delete:
            print("функция удаления ячейки сработала")
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
            
        }
        
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        print("таблица закончила редактироваться")
        tableView.endUpdates()
        
    }
    
    @IBAction func resultButtonAction(_ sender: Any) {
        
        _ = ResultMeasure(indexPath: indexPathForResultAction!, viewController: self)
        
    }
    
    @IBAction func removeAllButtonAction(_ sender: Any) {
        
        let stations = fetchedResultController.fetchedObjects!
        
        
        for sta in stations {
            
            CoreDataManager.instance.persistentContainer.viewContext.delete(sta)
            
        }
        
        CoreDataManager.instance.saveContext()
    }
    
}
