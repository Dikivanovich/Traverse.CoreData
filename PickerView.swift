//
//  PickerView.swift
//  Demo
//
//  Created by ZhuXueliang on 15/10/15.
//  Copyright © 2015年 IOSSOCKET. All rights reserved.
//

import UIKit




class PickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    var pickerTextField: UITextField!
    var dataPicker: PickerViewModel!
    var sideCircleLabel: UILabel!
    
    
    func pickerDoneAction() {
        
        let degree = (selectedRow(inComponent: 0) % 360).description
        let minutes = (selectedRow(inComponent: 1) % 60).description
        let seconds = (selectedRow(inComponent: 2) % 60).description
        
        pickerTextField.text! = degree + "˚ " + minutes + "' " + seconds + "\""
        pickerTextField.resignFirstResponder()
        
    }
    
    func pickerBackSpaceAction() {
        
        pickerTextField.deleteBackward()
        
    }
    
    func configPickerView(textField: UITextField, dataForPicker: PickerViewModel) {
        
        
//        MARK: - настройка кнопки "Готово":
        let doneButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self , action: #selector(pickerDoneAction))
        
        
//        MARK: - настройка панели инструментов над PickerView
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        toolBar.backgroundColor = #colorLiteral(red: 0.7893511048, green: 0.5545151219, blue: 0.9658150404, alpha: 1)
        toolBar.layer.borderColor = #colorLiteral(red: 0.9927669799, green: 0.9711497692, blue: 1, alpha: 1).cgColor
        toolBar.setItems([doneButtonItem], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        
        var switchButton = UISwitch()
        switchButton = UISwitch(frame: CGRect(x: toolBar.frame.maxX - UISwitch().frame.maxX - 10, y: toolBar.bounds.minY + 6, width: UISwitch().bounds.width, height: UISwitch().bounds.height))
        
        switchButton.setOn(false, animated: false)

        sideCircleLabel = UILabel(frame: CGRect(x: toolBar.frame.midX - 55, y: switchButton.bounds.minY, width: switchButton.bounds.width + 50, height: toolBar.bounds.height))
        sideCircleLabel.textAlignment = .center
        if switchButton.isOn {
            print("Switch функция работает")
            sideCircleLabel.text = "Круг лево"
            sideCircleLabel.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else {
            sideCircleLabel.text = "Круг право"
            sideCircleLabel.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        toolBar.addSubview(sideCircleLabel)
        toolBar.addSubview(switchButton)

        
        
        //        MARK: - настройка PickerView:
        dataSource = self
        delegate = self
        self.dataPicker = dataForPicker
        self.selectRow(dataForPicker.degree.count / 2 , inComponent: 0, animated: false)
        self.selectRow(dataForPicker.minutes.count / 2 , inComponent: 1, animated: false)
        self.selectRow(dataForPicker.seconds.count / 2 , inComponent: 2, animated: false)
        
        //        MARK: - настройка textField:
        textField.inputView = self
        textField.clearButtonMode = .whileEditing
        textField.inputAccessoryView = toolBar
        pickerTextField = textField

    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 3
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case 0:
            return dataPicker.degree.count
            
        case 1:
            
            return dataPicker.minutes.count
            
        case 2:
            
            return dataPicker.seconds.count
        default:
            return 0
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("функция назначения имени значений строк в компонентах работает")
        switch component {
        case 0: // degree
            return "\(dataPicker.degree[row % 360])"
            
        case 1: // minutes
            return "\(dataPicker.minutes[row % 60])"
            
        case 2: // seconds
            
            return "\(dataPicker.seconds[row % 60])"
        default:
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerTextField.text! = (selectedRow(inComponent: 0) % 360).description + "˚ " + (selectedRow(inComponent: 1) % 60).description + "' " + (selectedRow(inComponent: 2) % 60).description + "\""
        
    }
    
    
}
