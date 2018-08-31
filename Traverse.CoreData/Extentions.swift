//
//  Extentions.swift
//  Traverse.CoreData
//
//  Created by Dik on 06.06.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//


import UIKit


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
            
            
            self.text!.remove(at: self.text!.startIndex)
            
            
            
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
        
        
        
        self.resignFirstResponder()
        
    }
    
}

    



