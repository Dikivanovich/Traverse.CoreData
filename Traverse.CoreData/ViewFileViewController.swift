//
//  ViewFileViewController.swift
//  Traverse.CoreData
//
//  Created by Dik on 02.09.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ViewFileViewController: UIViewController {
    
        var presentedText: String?
        
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = presentedText!
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
