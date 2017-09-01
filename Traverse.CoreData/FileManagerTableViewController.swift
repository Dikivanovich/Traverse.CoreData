//
//  FileManagerTableViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import CoreData

class FileManagerTableViewController: UITableViewController {
    
    let url = URL(fileURLWithPath: "/Volumes/Data/Users/Dik/Documents/SwiftTest/Traverse.CoreData/Traverse.CoreData/Assets.xcassets/MeasureFiles/30KAT.txt", isDirectory: true)
    
    @IBAction func unwindFromViewFileController(sender: UIStoryboardSegue) {
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = NSData(contentsOf: url)
        
        let fetchRequestFile: NSFetchRequest<File> = File.fetchRequest()
        
        do {
            
           let files = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestFile)
            
            if files.count == 0 {
                
             let file = File()
                
             let fileName = FileName()
                
            file.file = data
             
            fileName.name = url.pathComponents.last
        
             file.fileName = fileName
              
            CoreDataManager.instance.saveContext()
                
            }
     
        } catch  {
            print(error)
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let fetchRequestFile: NSFetchRequest<File> = File.fetchRequest()
        
        do {
            
            let fileResults = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestFile)
            
            return fileResults.count
            
            
        } catch  {
            return 0
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)

        let fetchRequestFile: NSFetchRequest<File> = File.fetchRequest()
        
        do {
            
            let fileResults = try CoreDataManager.instance.persistentContainer.viewContext.fetch(fetchRequestFile)

            cell.textLabel?.text = fileResults.first!.fileName?.name!
            
            print("\(fileResults.first!.fileName!.name!)")
            
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
