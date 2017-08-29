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
    
    var selectedPoint: Point?
    
    var indexPathSelectedPoint: IndexPath?
    
    var leftCircle = Bool()
    
    let formater = DateFormatter()
    
    func leftCircleTrue() {
        
        leftCircle = true
        print("\nОтчет по горизонтальному лимбу при КЛ")
        
    }
    
    func leftCircleFalse() {
        
        leftCircle = false
        print("\nОтчет по горизонтальному лимбу при КП")
    }
    
    @IBAction func unwindFromDetailPointVC (sender: UIStoryboardSegue) {
        
        
        
        tableView.reloadData()
        
    }
    
    @IBOutlet weak var addMeasureButton: UIBarButtonItem!
    
    @IBAction func addNewMeasure(_ sender: Any) {
        
        leftCircle = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(leftCircleTrue), name: NSNotification.Name.init(rawValue: "leftCircleTrue"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(leftCircleFalse), name: NSNotification.Name.init(rawValue: "leftCircleFalse"), object: nil)
        
        //        MARK: - инициализация основного контроллера для запроса ввода имени пункта наблюдения:
        
        let alert = UIAlertController.init(title: "Добавьте наблюдение", message: "Введите имя пункта наблюдения", preferredStyle: .alert)
        
        alert.addTextField {  (texfield) in
            texfield.placeholder = "Название пункта"
        }
        
        let alertActionOK = UIAlertAction.init(title: "Сохранить", style: .default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
                //MARK:- •  инициализация запроса положения измерения (фиксированное или вычисляемое):
                
                let alertFixedOrNotPoint = UIAlertController.init(title: "Категория положения цели", message: "Является ли положение цели фиксированным", preferredStyle: .actionSheet)
                
                //MARK:•  инициализация действия кнопки да:
                
                let alertActionYes = UIAlertAction.init(title: "Да", style: .default, handler: { (alertAction) in
                    
                    
                    //MARK:-  • инициализация контроллера с полями для ввода данных измеряемой точки:
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
                        
                        self.savePoint(alertNamePoint: alert, alertController: alertInsertCoordinateController) // сохранение точки в базу данных.
                        
                    })
                    
                    let alertAddCoordinatCancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (alertAction) in
                        print("push cancel")
                    })
                    
                    alertInsertCoordinateController.addAction(alertAddCoordinatAction)
                    alertInsertCoordinateController.addAction(alertAddCoordinatCancelAction)
                    self.present(alertInsertCoordinateController, animated: true, completion: nil)
                    
                    for textField in alertInsertCoordinateController.textFields! {
                        
                        let container = textField.superview
                        let effectView = container?.superview?.subviews[0]
                        if (effectView != nil) {
                            
                            container?.backgroundColor = UIColor.clear
                            effectView?.removeFromSuperview()
                            
                        }
                        
                    }
                    
                })
                
                //MARK:- •  действие при вычисляемом положении измерения (когда координаты неизвестны):
                
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
                        
                        self.savePoint(generalAlertController: alert , alertController: alertInsertMeasureController) // сохранение точки в базу данных
                        
                    })
                    
                    let alertAddMeasureCancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: { (alertAction) in
                        print("push cancel")
                    })
                    
                    alertInsertMeasureController.addAction(alertAddMeasureAction)
                    alertInsertMeasureController.addAction(alertAddMeasureCancelAction)
                    self.present(alertInsertMeasureController, animated: true, completion: nil)
                    
                    for textField in alertInsertMeasureController.textFields! {
                        
                        let container = textField.superview
                        let effectView = container?.superview?.subviews[0]
                        if (effectView != nil) {
                            
                            container?.backgroundColor = UIColor.clear
                            effectView?.removeFromSuperview()
                            
                        }
                        
                    }
                    
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
        
        checkingStatusPoint()
        
        formater.dateFormat = "dd-MM-yy HH:mm"
        
        leftCircle = true
        
        //      MARK: - Настройка navigationItem
        
        navigationItem.title = "Наблюдения"
        navigationItem.prompt = "Станция: \(didSelectedStation!.nameStation!)"
        
        //      MARK: - Настройка визуализации TableViewController
        tableView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sortDescriptor = NSSortDescriptor(key: "dateInit", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor])
        
        if points?.count == 0 {
            
        }
        
        return points!.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellPoints", for: indexPath) as! CustomCell
        
        let sortDescriptor = NSSortDescriptor(key: "dateInit", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor]) as! [Point] 
        let point = points[indexPath.row]
        
        cell.namePointLabel.text = point.namePoint
        cell.dataInitLabel.text = formater.string(from: point.dateInit! as Date)
        
        
        
        if point.measurement?.horizontalAngle?.leftCircle == true {
            
            cell.verticalCirclePositionLabel.text! = "КЛ"
            
            
        } else {
            
            cell.verticalCirclePositionLabel.text! = "КП"
            
        }
        
        if points[indexPath.row].fixed == true {
            
            cell.backgroundColor = UIColor.orange
            cell.fixedPositionLabel.text = "Фиксированная"
            cell.detailTextLabel?.text = "\nПункт измерения: \(didSelectedStation!.nameStation!)" + "\nДата наблюдения: \(point.returnStringDate())"
            
        } else {
            
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.fixedPositionLabel.text = "Вычисляемая"
            cell.detailTextLabel?.text = "Вычисляемая" + "\nПункт измерения: \(didSelectedStation!.nameStation!)" + "\nДата создания наблюдения: \(point.returnStringDate())"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deletAction = UITableViewRowAction.init(style: .default, title: "Удалить") { (alertAction, indexPath) in
            // Delete the row from the data source
            
            let point = self.didSelectedStation?.point?.allObjects[indexPath.row] as! Point
            CoreDataManager.instance.persistentContainer.viewContext.delete(point)
            
            CoreDataManager.instance.saveContext()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
        
        return [deletAction]
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let sortDescriptor = NSSortDescriptor(key: "dateInit", ascending: false)
        let points = didSelectedStation?.point?.sortedArray(using: [sortDescriptor]) as! [Point]
        selectedPoint = points[indexPath.row]
        indexPathSelectedPoint = indexPath
        
        return indexPath
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailPointMeasure" {
            
            (segue.destination as! DetailPointMeasureViewController).willSelectedPoint = selectedPoint
            
        }
        
        
        if segue.identifier == "DetailPointMesure" {
            
            (segue.destination as! DetailPointMeasureViewController).indexPathSelectedPoint = indexPathSelectedPoint
            
        }
        
        if segue.identifier == "DetailPointMeasure" {
            
            (segue.destination as! DetailPointMeasureViewController).willSelectedStation = didSelectedStation
            
        }
        
    }
    
    deinit {
        
        print("\n\(self.debugDescription)Экземпляр класса удален из оперативной памяти")
        
    }
    
}


