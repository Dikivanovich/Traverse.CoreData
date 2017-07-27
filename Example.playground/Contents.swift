//: Playground - noun: a place where people can play

import UIKit

class MeasurementAngle {
    
  private var textField: UITextField?
    var degree: Int16?
    var minutes: Int16?
    var seconds: Int16?
    var textValue: String?
    var radianValue: NSDecimalNumber?
    
private func setup() {
        
        if textField?.text != nil  {
            var textAngle = textField?.text!
            let replacingText: [String] = ["˚", "'", "\""]
            for item in replacingText {
                textAngle = textAngle?.replacingOccurrences(of: item, with: "")
            }
            let splityngText: [String.CharacterView] = textAngle!.characters.split(separator: " ")
            let degreeText = String(splityngText[0])
            let minutesText = String(splityngText[1])
            let secondsText = String(splityngText[2])
            
            degree = Int16(degreeText)!
            minutes = Int16(minutesText)!
            seconds = Int16(secondsText)!
        }
    
    if degree != nil && minutes != nil && seconds != nil {
        textValue = "\(degree!)˚ " + "\(minutes!)' " + "\(seconds!)\""
    }
    
    if degree != nil && minutes != nil && seconds != nil {
        radianValue = NSDecimalNumber(value: Double(degree!) + Double(minutes!)/60 + Double(seconds!)/60)
    }
 }
    init(textField: UITextField) {
        self.textField = textField
        setup()
    }

}

var textField = UITextField()
var textFieldTwo = UITextField()
var textFieldTree = UITextField()

textField.text = "12˚ 10' 15\""
textFieldTwo.text = "35˚ 23' 16\""
textFieldTree.text = "48˚ 57' 33\""

let angle = MeasurementAngle(textField: textField)
angle.degree
angle.minutes
angle.seconds
angle.radianValue
angle.textValue

let angleTwo = MeasurementAngle(textField: textFieldTwo)
angleTwo.textValue
angleTwo.degree












