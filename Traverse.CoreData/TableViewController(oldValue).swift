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

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    

    let prob = Station()
    
    
    var fetchedResultsController:NSFetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Station", sortBy: "nameStation")

    
    
    
    @IBAction func addNewStationAction(_ sender: Any) {
        
        let alert = UIAlertController.init(title: "Добавьте станцию", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Название"
        }
        
        let alertActionAdd = UIAlertAction.init(title: "Добавить", style: UIAlertActionStyle.default) { (alertAction) in
            if alert.textFields?.first?.text != "" {
                
                CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, date: CurrentData.instance.returnDate())
                self.tableView.reloadData()
                
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
        
        
        fetchedResultsController.delegate = self
        
        do {
            
            try fetchedResultsController.performFetch()
            
        } catch  {
            
            print(error)
            
        }
        
        
        func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
            
            tableView.beginUpdates()

        }
        
        func controllerDidChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
            
            tableView.endUpdates()
        }
        
        
        func controller(controller: NSFetchedResultsController<NSFetchRequestResult>, didChangeObject anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            switch type {
            
            case .insert:
                    tableView.insertRows(at: [newIndexPath!], with: .automatic)
               
            case .update:
                    tableView.reloadRows(at: [indexPath!], with: .automatic)
            case .move:
                
                    tableView.moveRow(at: indexPath!, to: newIndexPath!)
                
            case .delete:
                
                    tableView.deleteRows(at: [indexPath!], with: .automatic) }
            
        }
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
            
            switch type {
            case .insert :
                tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
                
            case .delete :
                tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
                
            case .move :
                
                tableView.reloadSections(IndexSet(integer: sectionIndex), with: .automatic)
                
            default:
                break
            }
            
        }
       


        
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
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return fetchedResultsController.sections?[section].numberOfObjects ?? 0

    
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                // Configure the cell...
//        guard let sections = fetchedResultsController.sections
//            else {
//            fatalError("Section mossing")
//        }
//        let section = sections[indexPath.section]
//        
//        guard let itemsInSection = section.objects as? [Station] else {
//            fatalError("Section missing")
//        }
//        
//        let station = itemsInSection[indexPath.row]
//        
//        cell.textLabel?.text! = station.nameStation!
//        
//        cell.detailTextLabel?.text! = station.dateInitStation!
        
        let pro = CoreDataManager.instance.fetchedResultsController(entityName: "nameStation", sortBy: "name")
       let sta = pro.fetchRequest
        do {
           let station = try sta.execute()
            
            
                cell.textLabel?.text = station[indexPath.row].nameStation
            
            
        } catch  {
           
            print(error)
            
        }
        
        
        
        
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
        
        let managedObject = fetchedResultsController.object(at: indexPath) as NSManagedObject
        CoreDataManager.instance.persistentContainer.viewContext.delete(managedObject)
        CoreDataManager.instance.saveContext()

      
        
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
