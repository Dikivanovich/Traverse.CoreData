//
//  StationsTableViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 03.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData
import Foundation



class StationsTableViewController: UITableViewController, KeyboardDelegate   {
    
    

    let customKeyboard = MyCustomKeyboard.instance.loadFromNib()
    
    var selectedStation = String()
    
    
    
    var buttonText: String = "" {
        
        didSet{
            
            
            print("текст изменился на \(buttonText)")
            
        }
        
        willSet {
            
            
        }
        
        
    }
    
   func keyWasTapped(_ text: String) {
        
    
        
        buttonText.append(text)
        
        print("Клавиша \(text) перешла")
        
        
    }
    
   

    
    
    
    
    @IBAction func addNewStationAction(_ sender: Any) {
        
        
        
        let alert = UIAlertController.init(title: "Добавьте станцию", message: "Введите в текстовое поле имя вашей новой станции", preferredStyle: UIAlertControllerStyle.alert)
        
        
        alert.addTextField { (textField) in
            textField.placeholder = "Название"
            
        }
        
        let alertActionAdd = UIAlertAction.init(title: "Добавить", style: UIAlertActionStyle.default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
               
                let alertFixedOrNotStation = UIAlertController.init(title: "Положение станции", message: "Является ли положение станции фиксированным", preferredStyle: UIAlertControllerStyle.actionSheet)
                
                
                let alertActionFixedStation = UIAlertAction.init(title: "Да", style: UIAlertActionStyle.default, handler: { (alertAction) in
                    
                    let alertInputCoordinateController = UIAlertController.init(title: "Координаты станции", message: "Введите координаты станции", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alertInputCoordinateController.addTextField(configurationHandler: { (textFieldX)  in
                        
                        textFieldX.inputView = self.customKeyboard
                        
                       textFieldX.placeholder = "координата x"
                        
                        textFieldX.text = self.buttonText
                        
                    })
                    
                    
                    alertInputCoordinateController.addTextField(configurationHandler: { (textFieldY) in
                        
                        textFieldY.inputView = self.customKeyboard
                        textFieldY.placeholder = "координата y"
                        
                    })
                    
                    alertInputCoordinateController.addTextField(configurationHandler: { (textFieldZ) in
                        
                        textFieldZ.inputView = self.customKeyboard
                        textFieldZ.placeholder = "координата z"
                        
                    })

                    
                    
                    
                        let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: { (alertAction) in
                            if alertInputCoordinateController.textFields?[0].text! != "" && alertInputCoordinateController.textFields?[1].text! != "" && alertInputCoordinateController.textFields?[2].text! != "" {
                                
                                CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, date: CurrentData.instance.returnDate(), fixed: true, x: alertInputCoordinateController.textFields![0].text!, y: alertInputCoordinateController.textFields![1].text!, z: alertInputCoordinateController.textFields![2].text!)
                                self.tableView.reloadData()
                           }
                            
                            
                            
                        })
                    
                    let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
                        print("push cancel")
                        
                        
                        
                        
                        
                    }
                    
                    alertInputCoordinateController.addAction(alertAddCoordinatAction)
                    alertInputCoordinateController.addAction(alertActionCancel)
                    self.present(alertInputCoordinateController, animated: true, completion: nil)
                    
                  
                    
                    
                    
                    })
                
                    
                    
                
                
                
                let alertActionNotFixedStation = UIAlertAction.init(title: "Нет", style: UIAlertActionStyle.default, handler: { (alertAction) in
                   
                    CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, date: CurrentData.instance.returnDate(), fixed: false)
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Настройка вида TableView
        self.tableView.backgroundColor = UIColor.gray
         MyCustomKeyboard.instance.delegate = self
       self.tableView.separatorColor = UIColor.magenta
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLineEtched
        
        
        

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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            return results.count
           
        } catch  {
            
            print(error)
            return 0
        }
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
              cell.textLabel?.text = results[indexPath.row].nameStation
            cell.detailTextLabel?.text = "Дата установки станции: " + results[indexPath.row].dateInitStation!
            
        } catch  {
            
            print(error)
            
        }
        // Configure the cell...
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source

            let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            do {
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
                
                CoreDataManager.instance.persistentContainer.viewContext.delete(results[indexPath.row])
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
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "ShowMeasurements" {
            
            
     (segue.destination as! MeasurementsListViewController).nameSelectedStation = selectedStation
     
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
     {
        
        let fetchRequest: NSFetchRequest<Station> = Station.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            
            let results = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequest)
            
            selectedStation = results[indexPath.row].nameStation!
            
        }
            
        catch {
            
            let err = error as NSError
            print(err.userInfo)
            
                    }
        
        return indexPath
        
    }
        
    
    
    }


