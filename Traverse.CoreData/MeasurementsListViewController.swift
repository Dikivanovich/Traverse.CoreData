//
//  MeasurementsListViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 08.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData


class MeasurementsListViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    
    var didSelectedStation: Station?
    
    
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
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldHorizontalAngle) in
                        
                        self.customozationTextFieldForPicker(textField: textFieldHorizontalAngle, placeholder: "горизонтальный лимб")
                        
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldVerticalAngle) in
                        
                        self.customozationTextFieldForPicker(textField: textFieldVerticalAngle, placeholder: "вертикальный круг")
                    })
                    
                    
                    
                    let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: {  (alertAction) in
                        
                        if  alertInsertCoordinateController.textFields?[0].text! != "" && alertInsertCoordinateController.textFields?[1].text! != "" && alertInsertCoordinateController.textFields?[2].text! != "" {
                            
                            CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, x: alertInsertCoordinateController.textFields![0].text! , y: alertInsertCoordinateController.textFields![1].text!, z: alertInsertCoordinateController.textFields![2].text!, fromStation: self.didSelectedStation!)
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
                    
                    let alertInsertMeasureController = UIAlertController.init(title: "Измерения на цель", message: "Введите отчет по горизонтальному и вертикальному лимбу", preferredStyle: .alert)
                    
                    alertInsertMeasureController.addTextField(configurationHandler: { (textFieldHorizontalAngle) in
                        
                        self.customozationTextFieldForPicker(textField: textFieldHorizontalAngle, placeholder: "горизонтальный лимб")
                        
                    })
                    
                    alertInsertMeasureController.addTextField(configurationHandler: { (textFieldVerticalAngle) in
                        
                        self.customozationTextFieldForPicker(textField: textFieldVerticalAngle, placeholder: "вертикальный угол")                    })
                    
                    let alertAddMeasureAction = UIAlertAction(title: "Сохранить", style: .default, handler: { (alertAction) in
                        
                        if alertInsertMeasureController.textFields?[0] != nil ?? alertInsertMeasureController.textFields?[1] {
                            
                           
                            
                        }
                        
                        
                        
                        
                        
                    })
                    
                    let alertAddMeasureCancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: { (alertAction) in
                        print("push cancel")
                    })
                    
                    alertInsertMeasureController.addAction(alertAddMeasureAction)
                    alertInsertMeasureController.addAction(alertAddMeasureCancelAction)
                    self.present(alertInsertMeasureController, animated: true, completion: nil)
                    
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
        
        guard let textProb = didSelectedStation?.nameStation else {
            print("ошибка в назначении имени станции")
            return
        }
        
        navigationItem.title = "Измерения"
        navigationItem.prompt = "Станция: \(String(describing: textProb))"
        
        //      MARK: - Настройка визуализации TableViewController
        tableView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sortDescriptor = NSSortDescriptor(key: "dateMeasure", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor])
        
        if points?.count == 0 {
            addNewMeasure((Any).self)
        }
        
        return points!.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPoints", for: indexPath) as! CustomCell
        
        cell.detailTextLabel?.numberOfLines = 6
        let sortDescriptor = NSSortDescriptor(key: "dateMeasure", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor]) as! [Points]
        let point = points[indexPath.row]
        
        cell.textLabel?.text = point.namePoint
        
        if points[indexPath.row].fixed == true {
            
            
            cell.detailTextLabel?.text = "Фиксированная" + "\nПункт измерения: \(didSelectedStation!.nameStation!)" + "\nx: \(point.x!)" + "\ny: \(point.y!)" + "\nz: \(point.z!)" + "\nДата создания наблюдения: \(point.dateMeasure!)"
            
        } else {
            
            cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            cell.detailTextLabel?.text = "Вычисляемая" + "\nСтанция: \(didSelectedStation!.nameStation!)" + "\nДата создания наблюдения: \(point.dateMeasure!)"
        }
        
        
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let point = didSelectedStation?.point?.allObjects[indexPath.row] as! Points
            
            CoreDataManager.instance.persistentContainer.viewContext.delete(point)
            CoreDataManager.instance.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }

}





