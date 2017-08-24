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
        
        
        
        self.resignFirstResponder()
        
    }
    
}

extension ResultMeasure {
    
    
    /// Функция выполняет вычисление измеренных углов. Она разбивает массив на парные значения, и вычисляет из заднего значения переднее.
    ///
    /// - Parameter forAngles: Аргументом функции является массив типа Double, которых хранит отчеты угла по горизонтальному кругу в радианах.
     func  differenceAngle(forAngles: inout [Double], viewController: UIViewController) {
        
        //MARK:- Проверка на достаточность измерений для вычисления хода:
         if forAngles.count % 2 != 0 {
            
            let alert = UIAlertController.init(title: "Ошибка", message: "Недостаточно измерений в точках хода при левом и/или правом круге! Проверьте журнал  измерений", preferredStyle: .alert)
            
            let action = UIAlertAction.init(title: "Ок", style: .default, handler: nil)
            
            alert.addAction(action)
            
            viewController.present(alert, animated: true, completion: nil)
         } else {
        
        var doubleArray = [Double]()
        var arr1 = [Double]()
        var arr2 = [Double]()
        var i = 0
        var n = 0
        for leftAngle in forAngles {
            
            if i%2 == 0 {
                
                arr2.append(leftAngle)
                
            } else {
                
                arr1.append(leftAngle)
                
            }
            
            i += 1
            
            if i == forAngles.count && (arr1.count + arr2.count)%2 == 0 { //  проверка количества измерений и их парность
                
                for item in arr1 {
                    
                    while n != arr1.count  {
                        
                        var measurementAngle = item - arr2[n]
                        
                        if measurementAngle < 0 {
                            
                            measurementAngle += 360
                            
                        }
                        
                        doubleArray.append(measurementAngle)
                        
                        n += 1
                    }
                    
                }
                
            }
            
        }
        
        forAngles.removeAll()
        forAngles = doubleArray
        
    }
    
}

}
    
extension ResultMeasure {
    
    
  
    
    
}



