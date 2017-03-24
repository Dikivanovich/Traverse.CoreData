//
//  TableViewController.swift
//  Traverse
//
//  Created by Dik on 15.03.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TableViewController: UITableViewController {
    
    
    var station = [StationTest]()
    
    
    
    
    @IBAction func addNewStationAction(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "Добавьте станцию", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Название"
        }
        
        let alertActionAdd = UIAlertAction.init(title: "Добавить", style: UIAlertActionStyle.default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
                self.saveData(nameStation: alert.textFields!.first!.text!)
                self.tableView.reloadData()
                
            }
            
            print("Станция добавлена, теперь список станций такой:")
            
            for i in self.station {
                
                print("\(i.name)")
                
            }
            
        }
        
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
            print("push cancel")
        }
        
        alert.addAction(alertActionAdd)
        alert.addAction(alertActionCancel)
        
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func saveData(nameStation: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newNameStation = NSEntityDescription.insertNewObject(forEntityName: "Station", into: context)
        
        newNameStation.setValue(nameStation, forKey: "nameStation")
        
        newNameStation.setValue(StationTest.init(name: nameStation, dateInitStation: CurrentData.init().returnDate()).dateInitStation, forKey: "dateInitStation")
        
        do  {
            
            try context.save()
            print("Saved \(newNameStation.value(forKey: "nameStation"))")
            let dateInitStation = newNameStation.value(forKey: "dateInitStation") as! String
            
            station.append(StationTest.init(name: nameStation, dateInitStation: dateInitStation))
            
           
            
            
        }  catch  {
            
            let err = error as NSError
            
            print("Не удалось создать станцию ошибка: \(err)")
            
        }
        
        
        
    }
    func loadData()  {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Station")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject]
                    
                {
                    
                    if let name = result.value(forKey: "nameStation") as? String {
                        let dateInitStation = result.value(forKey: "dateInitStation") as! String
                        
                        station.append(StationTest.init(name: name, dateInitStation: dateInitStation))
                        
                    }
                    
                }
            }
            
        } catch  {
            
            let error: NSError? = NSError()
            
            print("Станция отсутствует из-за ошибки: \(error!.userInfo)")
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        // Uncomment the following line to preserve selection between presentations
        //        self.clearsSelectionOnViewWillAppear = false
        
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
        // #warning Incomplete implementation, return the number of rows
        return station.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text! = station[indexPath.row].name
        
        cell.detailTextLabel?.text = station[indexPath.row].dateInitStation
        
        
        return cell
    }
    
    
    
    
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
