//
//  MeasurementsListViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 08.04.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit

class MeasurementsListViewController: UIViewController {
    
    var nameSelectedStation = String()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationItem.title = "Измерения"
        self.navigationItem.prompt = "Станция: \(nameSelectedStation)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
