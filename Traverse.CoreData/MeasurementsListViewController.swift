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
    
    var selectedPoint: Points?
    
    func alertControllerWillDisappear(textFields: [UITextField]?) {
        
        for textField in textFields! {
            textField.inputView = nil
        }
    }
    
    @IBAction func unwindFromDetailPointVC (sender: UIStoryboardSegue) {
        
       tableView.reloadData()
        
    }
    
    @IBOutlet weak var addMeasureButton: UIBarButtonItem!
    
    @IBAction func addNewMeasure(_ sender: Any) {
        
//        MARK: - создание основного контроллера для запроса ввода имени пункта наблюдения:
        
        let alert = UIAlertController.init(title: "Добавьте наблюдение", message: "Введите имя пункта наблюдения", preferredStyle: .alert)
        
        alert.addTextField {  (texfield) in
            texfield.placeholder = "Название пункта"
        }
        
        let alertActionOK = UIAlertAction.init(title: "Сохранить", style: .default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
//          MARK: - создание запроса положения измерения (фиксированное или вычисляемое):
                
                let alertFixedOrNotPoint = UIAlertController.init(title: "Категория положения цели", message: "Является ли положение цели фиксированным", preferredStyle: .actionSheet)
                
//                действие при фиксированном положении измерения (когда известны координаты):
                
               let alertActionYes = UIAlertAction.init(title: "Да", style: .default, handler: { (alertAction) in
                    
                    let alertInsertCoordinateController = UIAlertController.init(title: "Координаты цели", message: "Введите координаты цели", preferredStyle: .alert)
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldX)  in
                        
                        Customisation.instance.customozationTextField(textField: textFieldX, placeholder: "x", backgroundColor: UIColor.clear)
                        
                        
                        
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldY) in
                        
                        Customisation.instance.customozationTextField(textField: textFieldY, placeholder: "y", backgroundColor: UIColor.clear)
                        
                        
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (textFieldZ) in
                        
                        Customisation.instance.customozationTextField(textField: textFieldZ, placeholder: "z", backgroundColor: UIColor.clear)
                        
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {   (textFieldHorizontalAngle) in
                        
                        Customisation.instance.customozationTextFieldForPicker(textField: textFieldHorizontalAngle, placeholder: "горизонтальный лимб", showSideCircle: true)
                        
                        
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {   (textFieldVerticalAngle) in
                        
                        Customisation.instance.customozationTextFieldForPicker(textField: textFieldVerticalAngle, placeholder: "вертикальный круг", showSideCircle: false)
                    })
                    
                    alertInsertCoordinateController.addTextField(configurationHandler: {  (distanceTextField) in
                        Customisation.instance.customozationTextField(textField: distanceTextField, placeholder: nil, backgroundColor: UIColor.clear)
                    })
                    
                    
                    let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: {  (alertAction) in
                        
                        if  alertInsertCoordinateController.textFields?[0].text! != "" && alertInsertCoordinateController.textFields?[1].text! != "" && alertInsertCoordinateController.textFields?[2].text! != "" && alertInsertCoordinateController.textFields?[3].text! != "" && alertInsertCoordinateController.textFields?[4].text! != "" &&
                            alertInsertCoordinateController.textFields?[5].text! != "" {
                            
                            let angleHz = MeasurementAngle(textField: (alertInsertCoordinateController.textFields?[3])!)
                            let angleVz = MeasurementAngle(textField: (alertInsertCoordinateController.textFields?[4])!)
                            
                            CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, x: alertInsertCoordinateController.textFields![0].text! , y: alertInsertCoordinateController.textFields![1].text!, z: alertInsertCoordinateController.textFields![2].text!, fromStation: self.didSelectedStation!,distance: alertInsertCoordinateController.textFields![5].text!, hzAngle: angleHz, vAngle: angleVz)
                            self.tableView.reloadData()
                            self.alertControllerWillDisappear(textFields: alertInsertCoordinateController.textFields)
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
                
//                действие при вычисляемом положении измерения (когда координаты неизвестны):
                
                let alertActionNo = UIAlertAction.init(title: "Нет", style: .default, handler: { (alertAction) in
                    
                    let alertInsertMeasureController = UIAlertController.init(title: "Измерения на цель", message: "Введите отчет по горизонтальному и вертикальному лимбу", preferredStyle: .alert)
                    
                    alertInsertMeasureController.addTextField(configurationHandler: { (textFieldHorizontalAngle) in
                        
                        Customisation.instance.customozationTextFieldForPicker(textField: textFieldHorizontalAngle, placeholder: "горизонтальный лимб", showSideCircle: true)
                        
                    })
                    
                    alertInsertMeasureController.addTextField(configurationHandler: { (textFieldVerticalAngle) in
                        
                        Customisation.instance.customozationTextFieldForPicker(textField: textFieldVerticalAngle, placeholder: "вертикальный угол", showSideCircle: false)
                        
                    })
                    
                    alertInsertMeasureController.addTextField(configurationHandler: { (distanceTextField) in
                        
                        Customisation.instance.customozationTextField(textField: distanceTextField, placeholder: nil, backgroundColor: UIColor.clear)
                        
                    })
                    
                    let alertAddMeasureAction = UIAlertAction(title: "Сохранить", style: .default, handler: { (alertAction) in
                        
                        if alertInsertMeasureController.textFields?[0].text != "" && alertInsertMeasureController.textFields?[1].text != "" && alertInsertMeasureController.textFields?[2].text != ""  {
                            
                            let hzAngle = MeasurementAngle(textField: (alertInsertMeasureController.textFields?[0])!)
                            let vAngle = MeasurementAngle(textField: (alertInsertMeasureController.textFields?[1])!)
                            
                            CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, fromStation: self.didSelectedStation!,distance: alertInsertMeasureController.textFields![2].text! , hzAngle: hzAngle, vAngle: vAngle)
                            self.tableView.reloadData()
                            self.alertControllerWillDisappear(textFields: alertInsertMeasureController.textFields)
                        } else if alertInsertMeasureController.textFields?[0].text != "" && alertInsertMeasureController.textFields?[1].text == "" && alertInsertMeasureController.textFields?[2].text != "" {
                            
                            let hzAngle = MeasurementAngle(textField: (alertInsertMeasureController.textFields?[0])!)
                            CoreDataManager.instance.addNewMeasure(name: alert.textFields!.first!.text!, fromStation: self.didSelectedStation!, distance: alertInsertMeasureController.textFields![2].text!, hzAngle: hzAngle, vAngle: MeasurementAngle.init(textField: nil))
                            self.tableView.reloadData()
                            self.alertControllerWillDisappear(textFields: alertInsertMeasureController.textFields)
                            
                        } else {
                            
                            let alertError = UIAlertController.init(title: "Ошибка!", message: "Поле отчета по горизонтальному лимбу должно быть обязательно заполнено!", preferredStyle: UIAlertControllerStyle.alert)
                            
                            let alertErrorAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                                self.present(alertInsertMeasureController, animated: true, completion: nil)
                            })
                            
                            alertError.addAction(alertErrorAction)
                            
                            self.present(alertError, animated: true, completion: nil)

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
            
            cell.backgroundColor = UIColor.orange
            cell.detailTextLabel?.text = "Фиксированная" + "\nПункт измерения: \(didSelectedStation!.nameStation!)" + "\nДата наблюдения: \(point.dateMeasure!)"
            
        } else {
            
            cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            cell.detailTextLabel?.text = "Вычисляемая" + "\nПункт измерения: \(didSelectedStation!.nameStation!)" + "\nДата создания наблюдения: \(point.dateMeasure!)"
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let sortDescriptor = NSSortDescriptor(key: "dateMeasure", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor]) as! [Points]
         selectedPoint = points[indexPath.row]
        
        
        
        return indexPath
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailPointMeasure" {
            
            (segue.destination as! DetailPointMeasureViewController).willSelectedPoint = selectedPoint
        
    }
    
}
    
    deinit {
       
        print("класс MeasurementsListViewController деинициализируется")
    }
    
}


