//
//  Classes.swift
//  Traverse
//
//  Created by Dik on 14.03.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation
import UIKit

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

class CustomCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.7946271728, green: 0.6012833646, blue: 0.9686274529, alpha: 0.5649882277).cgColor
        self.clipsToBounds = true
        
        
    }
    
    
}

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

extension MeasurementsListViewController {
    


    
    
    /// Данная функция реализует кастомную клавиатуру для указанного в аргументе текстового поля.
    ///
    /// - Parameters:
    ///   - textField: Текстовое поле, над которым будет выполнена процедура настройки.
    ///   - placeholder: Текст, который должен указываться в placeholder выбранного текстовго поля.
    func customozationTextField(textField: UITextField, placeholder: String?) {
        textField.inputView = MyCustomKeyboard.init().loadFromNib()
        if placeholder != nil {
            textField.placeholder = "координата \(placeholder!)"
        }
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        let label = UILabel(frame: .init(x: -18, y: -11, width: 50, height: 50))
        label.textColor = #colorLiteral(red: 0.4691409734, green: 0.6283831361, blue: 0.9686274529, alpha: 1)
        if placeholder != nil { label.text = "\(placeholder!):"}
        textField.addSubview(label)
        
    }
    
    /// Данная функция реализует Custom Picker View для указанного в аргументе текстового поля.
    ///
    /// - Parameters:
    ///   - textField: Текстовое поле, над которым будет выполнена процедура настройки.
    ///   - placeholder: Текст, который должен указываться в placeholder выбранного текстовго поля.
    func customozationTextFieldForPicker(textField: UITextField, placeholder: String, showSideCircle: Bool) {
        
        let pickerView = PickerView.init()
        pickerView.configPickerView(textField: textField, dataForPicker: DataModel.getData(), showSideCircle: showSideCircle)
        textField.inputView = pickerView
        textField.placeholder = "\(placeholder)"
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.backgroundColor = #colorLiteral(red: 0.8642458376, green: 1, blue: 0.8972792964, alpha: 1)
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFontTextStyle.title1.rawValue, size: 20)

    
}

}


extension MeasurementsListViewController {
    
    func returnAngleFromTextField(textField: UITextField) -> (degree: Int16, minutes: Int16, seconds: Int16) {
        
        var textAngle = textField.text!
        let replacingText: [String] = ["˚", "'", "\""]
        for item in replacingText {
            textAngle = textAngle.replacingOccurrences(of: item, with: "")
        }
        let splityngText: [String.CharacterView] = textAngle.characters.split(separator: " ")
        
        let degreeText = String(splityngText[0])
        let minutesText = String(splityngText[1])
        let secondsText = String(splityngText[2])
        
        let angle = (degree: Int16(degreeText)!, minutes: Int16(minutesText)!, seconds: Int16(secondsText)!)
        
        return angle
        
    }
    
    
    
}











