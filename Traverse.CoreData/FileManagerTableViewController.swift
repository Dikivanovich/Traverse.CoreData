//
//  FileManagerTableViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 01.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class FileManagerTableViewController: UITableViewController {
    
    // MARK:-   Properties

    let fileManager = FileManager()
    
    let tempDir = NSTemporaryDirectory()
    
    var measureJurnal = String()
    
//    let url = URL(fileURLWithPath: "/Volumes/Data/Users/Dik/Documents/SwiftTest/Traverse.CoreData/Traverse.CoreData/Assets.xcassets/MeasureFiles/xhodt2-3.09.2015.txt", isDirectory: true)
    
    var selectedFile: String?
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func unwindFromViewFileController(sender: UIStoryboardSegue) {
        
        if activityIndicator.isAnimating {
            
            activityIndicator.stopAnimating()
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(fileURLWithPath: Bundle.main.path(forResource: "xhodt2-3.09.2015", ofType: "txt")!) as URL
        
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
                
                print("Файл добавлен в модель данных")
                
            }
 
            
        } catch  {
            print(error)
        }
 
        
        let componentsToDisplay = fileManager.componentsToDisplay(forPath: tempDir) ?? []
        
        print(componentsToDisplay)
        
        if componentsToDisplay.contains(url.pathComponents.last!) == false && componentsToDisplay.count != 0 {
            
                let path = (tempDir as NSString).appendingPathComponent(url.pathComponents.last!)

                do {
                    
            let textData = try NSString(contentsOf: url, encoding: String.Encoding.utf8.rawValue)
                    
             try textData.write(toFile: path, atomically: true, encoding: String.Encoding.utf8.rawValue)
                } catch {
                    print(error)
                }
                
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
        
        
        
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
        
        
        
        do {
            
            let filesInDirectiry = try fileManager.contentsOfDirectory(atPath: tempDir)
            
            return filesInDirectiry.count
            
            
        } catch  {
            return 0
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell", for: indexPath)
        
        do {
            
             let filesInDirectiry = try fileManager.contentsOfDirectory(atPath: tempDir)
            
            cell.textLabel?.text = filesInDirectiry[indexPath.row]
            
        } catch  {
            print(error)
        }
        
         return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
       activityIndicator.startAnimating()
        
        do {
           let file = try fileManager.contentsOfDirectory(atPath: tempDir)[indexPath.row]
            
            let patch = (tempDir as NSString).appendingPathComponent(file)
          
            selectedFile = try NSString(contentsOfFile: patch, encoding: String.Encoding.utf8.rawValue) as String
            
            
        } catch  {
            print(error)
        }
        
        
               measureJurnal = formatingText(textToFormat: selectedFile! as NSString)
        
        
     
        
     
        
     return indexPath
        
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

    
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GoToViewFile" {
            
            (segue.destination as! ViewFileViewController).presentedText = measureJurnal
            
        }
        
        activityIndicator.stopAnimating()
        
    }
    

}
