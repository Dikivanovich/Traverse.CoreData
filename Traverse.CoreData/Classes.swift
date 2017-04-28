//
//  Classes.swift
//  Traverse
//
//  Created by Dik on 14.03.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit


struct Position {
    var x: Double?
    var y: Double?
    var z: Double?
}

class CurrentData {
    
  static let instance = CurrentData()
    
    
   func returnDate() -> String
    {
        let date = NSDate()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
        let dateString = dateFormater.string(from: date as Date)
        return dateString
    }
  
    private init() {}
}


class StationTest {
    
    var dateInitStation: String
    
    var name: String
    
    var position = Position()
    
    
    
    init(name: String, dateInitStation: String) {
        self.name = name
        self.dateInitStation = dateInitStation
        position = Position()
        
    }
    
    
 
        
    }
    

 class CustomCell: UITableViewCell {
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.cyan.cgColor
        self.backgroundColor = UIColor.orange
        self.clipsToBounds = true
    self.layer.shadowColor = UIColor.magenta.cgColor
    
        
    }
    
    
}

//class TextFieldPresentation: UITextField {
//    
//    
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//        self.layer.cornerRadius = 10
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.brown.cgColor
//        inputView = MyCustomKeyboard.instance.loadFromNib()
//        
//        
//    }
//    
//}


extension UITextField {
    
    
    
    
    @IBAction func pressOne(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)
        
        
            }
    
    @IBAction func pressTwo(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)
        
        
    }
    
    @IBAction func pressThree(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)
        
        
    }
    
    @IBAction func pressFour(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressFive(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressSix(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressSeven(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressEight(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressNine(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressZero(_ sender: UIButton) {
        self.insertText(sender.currentTitle!)

    }
    
    @IBAction func pressMinus(_ sender: UIButton) {
        
        
        let minusText = sender.currentTitle!
        
        
        
            
            if self.text!.contains(minusText) == true {
                
                
                self.text!.remove(at: self.text!.characters.startIndex)
                
                
                
            } else if self.text!.contains(minusText) == false {
                
                self.text?.insert(Character(minusText), at: self.text!.startIndex)
            }
            
        
    }
    
    @IBAction func pressComma(_ sender: CustomButton) {
        
        let comma = sender.currentTitle!
        
        
        
        if self.text!.contains(comma) == true  {
            
        } else {
            self.insertText(comma)
        }

        
        
    }
    
    @IBAction func pressBackSpace(_ sender: UIButton) {
        
        self.deleteBackward()

        
        
    }
    @IBAction func pressEnter(_ sender: UIButton) {
        
        
//        self.resignFirstResponder()
        self.resignFirstResponder()
        
    }

    
    
        
        
    
    
}



