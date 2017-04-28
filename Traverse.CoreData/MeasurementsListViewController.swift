//
//  MeasurementsListViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 08.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MeasurementsListViewController: UITableViewController {
    
    var nameSelectedStation: Station?
    var indexPathSelectedStation: IndexPath?
    
    func customozationTextField(textField: UITextField, placeholder: String) {
        
        textField.inputView = MyCustomKeyboard.init().loadFromNib()
        textField.placeholder = "координата \(placeholder)"
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.repeatCount = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        
        let label = UILabel(frame: .init(x: -18, y: -11, width: 50, height: 50))
        label.textColor = #colorLiteral(red: 0.4691409734, green: 0.6283831361, blue: 0.9686274529, alpha: 1)
        label.text = "\(placeholder):"
        textField.addSubview(label)
        
    }

    
    @IBAction func addNewMeasure(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "Добавьте наблюдение", message: "Введите имя пункта наблюдения", preferredStyle: .alert)
        
        alert.addTextField { (texfield) in
            texfield.placeholder = "Название пункта"
        }
        
        let alertActionOK = UIAlertAction.init(title: "Сохранить", style: .default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
                
                let alertFixedOrNotPoint = UIAlertController.init(title: "Категория положения цели", message: "Является ли положение цели фиксированным", preferredStyle: .actionSheet)
                
                
                let alertActionYes = UIAlertAction.init(title: "Да", style: .default, handler: { (alertAction) in
                    
                    let alertInsertCoordinateController = UIAlertController.init(title: "Координаты цели", message: "Введите координаты цели", preferredStyle: .alert)
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldX)  in
                        
                        self.customozationTextField(textField: textFieldX, placeholder: "x")
                        
                        
                    })
                    
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: { (textFieldY) in
                        
                        self.customozationTextField(textField: textFieldY, placeholder: "y")
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: { (textFieldZ) in
                        
                        self.customozationTextField(textField: textFieldZ, placeholder: "z")
                        
                    })

                    let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: {  (alertAction) in
                        
                        if  alertInsertCoordinateController.textFields?[0].text! != "" && alertInsertCoordinateController.textFields?[1].text! != "" && alertInsertCoordinateController.textFields?[2].text! != "" {
                            
                            CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, x: alertInsertCoordinateController.textFields![0].text! , y: alertInsertCoordinateController.textFields![1].text!, z: alertInsertCoordinateController.textFields![2].text!, station: self.indexPathSelectedStation!)
                            self.tableView.reloadData()
                        } else {
                            
                            
                            let alertError = UIAlertController.init(title: "Ошибка!", message: "Введите координаты пункта наблюдения!", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let alertErrorAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                                self.present(alertInsertCoordinateController, animated: true, completion: nil)
                            })
                            
                            alertError.addAction(alertErrorAction)
                            
                            self.present(alertError, animated: true, completion: nil)
                            
                        }
                        
                    })
                    
                    let alertAddCoordinatCancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (alertAction) in
                        print("push cancel")
                    })
                    
                    alertInsertCoordinateController.addAction(alertAddCoordinatAction)
                    alertInsertCoordinateController.addAction(alertAddCoordinatCancelAction)
                   self.present(alertInsertCoordinateController, animated: true, completion: nil)
                    
                    
                })
                
                let alertActionNo = UIAlertAction.init(title: "Нет", style: .default, handler: { (alertAction) in
                    
                    CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, station: self.indexPathSelectedStation!)
                    self.tableView.reloadData()
                    
                })
                
                alertFixedOrNotPoint.addAction(alertActionYes)
                alertFixedOrNotPoint.addAction(alertActionNo)
                self.present(alertFixedOrNotPoint, animated: true, completion: nil)
                
            }            
            
            
            
        }
        
        let alertActionCancel = UIAlertAction.init(title: "Отмена", style: UIAlertActionStyle.cancel) { (alertAction) in
            
        }
        
        alert.addAction(alertActionOK)
        alert.addAction(alertActionCancel)
        self.present(alert, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//      MARK: - Настройка navigationItem
    
        navigationItem.title = "Измерения"
        navigationItem.prompt = "Станция: \( nameSelectedStation!.nameStation!)"
        
//      MARK: - Настройка визуализации TableViewController
        tableView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        

    
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
             let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            let points = stations[indexPathSelectedStation!.row].point?.count
            
        return points!
        
        
        } catch  {
            return 0
        }
        
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPoints", for: indexPath)
        cell.detailTextLabel?.numberOfLines = 5
        
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
          let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            let points = stations[indexPathSelectedStation!.row].point?.allObjects as! [Points]
                
                cell.textLabel?.text = points[indexPath.row].namePoint
            
            if points[indexPath.row].fixed == true {
                
                cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
                cell.detailTextLabel?.text = "Фиксированная" + "\nПункт измерения: \(stations[indexPathSelectedStation!.row].nameStation!)" + "\nx: \(points[indexPath.row].x!)" + "\ny: \(points[indexPath.row].y!)" + "\nz: \(points[indexPath.row].z!)"
            } else {
                
                cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                cell.detailTextLabel?.text = "Вычисляемая" + "\nСтанция: \(stations[indexPathSelectedStation!.row].nameStation!)"
            }
                
            
        } catch  {
            print(error)
        }
        
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let stations = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
                let points = stations[indexPathSelectedStation!.row].point?.allObjects as! [Points]
                
                CoreDataManager.instance.persistentContainer.viewContext.delete(points[indexPath.row])
                CoreDataManager.instance.saveContext()
                
            }
                
            catch {
                
                let err = error as NSError
                print(err.userInfo)
                
                
            }
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        
        //         else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
    }
        
        
        
        
    }
    
   
  


