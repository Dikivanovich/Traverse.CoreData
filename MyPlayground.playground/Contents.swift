import UIKit


let alert = UIAlertController.init(title: "Добавьте станцию", message: "Введите в текстовое поле имя вашей новой станции", preferredStyle: UIAlertControllerStyle.alert)


alert.addTextField { (textField) in
    textField.placeholder = "Название"
    
}

let alertActionAdd = UIAlertAction.init(title: "Добавить", style: UIAlertActionStyle.default) { (alertAction) in
    if alert.textFields?.first?.text != "" {
        
        
        let alertFixedOrNotStation = UIAlertController.init(title: "Положение станции", message: "Является ли положение станции фиксированным", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let alertActionFixedStation = UIAlertAction.init(title: "Да", style: UIAlertActionStyle.default, handler: { (alertAction) in
            
            let alertInputCoordinateController = UIAlertController.init(title: "Координаты станции", message: "Введите координаты станции", preferredStyle: UIAlertControllerStyle.alert)
            
            
            
            
            
            
            
            alertInputCoordinateController.addTextField(configurationHandler: { (textFieldX)  in
                
                textFieldX.inputView = MyCustomKeyboard.instance.loadFromNib()
                
                
                
                textFieldX.placeholder = "координата x"
                
                
                
            })
            
            
            alertInputCoordinateController.addTextField(configurationHandler: { (textFieldY) in
                
                textFieldY.inputView = self.customKeyboard
                textFieldY.placeholder = "координата y"
                
            })
            
            alertInputCoordinateController.addTextField(configurationHandler: { (textFieldZ) in
                
                textFieldZ.inputView = self.customKeyboard
                textFieldZ.placeholder = "координата z"
                
            })
            
            
            
            
            let alertAddCoordinatAction = UIAlertAction.init(title: "Сохранить", style: UIAlertActionStyle.default, handler: { (alertAction) in
                if alertInputCoordinateController.textFields?[0].text! != "" && alertInputCoordinateController.textFields?[1].text! != "" && alertInputCoordinateController.textFields?[2].text! != "" {
                    
                    CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, date: CurrentData.instance.returnDate(), fixed: true, x: alertInputCoordinateController.textFields![0].text!, y: alertInputCoordinateController.textFields![1].text!, z: alertInputCoordinateController.textFields![2].text!)
                    self.tableView.reloadData()
                }
                
                
                
            })
            
            let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
                print("push cancel")
                
                
                
                
                
            }
            
            alertInputCoordinateController.addAction(alertAddCoordinatAction)
            alertInputCoordinateController.addAction(alertActionCancel)
            self.present(alertInputCoordinateController, animated: true, completion: nil)
            
            
            
            
            
        })
        
        
        
        
        
        
        let alertActionNotFixedStation = UIAlertAction.init(title: "Нет", style: UIAlertActionStyle.default, handler: { (alertAction) in
            
            CoreDataManager.instance.addNewStation(name: alert.textFields!.first!.text!, date: CurrentData.instance.returnDate(), fixed: false)
            self.tableView.reloadData()
            
        })
        
        alertFixedOrNotStation.addAction(alertActionFixedStation)
        alertFixedOrNotStation.addAction(alertActionNotFixedStation)
        
        self.present(alertFixedOrNotStation, animated: true, completion: nil)
        
        
    }
    
}

let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
    print("push cancel")
    
}






alert.addAction(alertActionAdd)
alert.addAction(alertActionCancel)


self.present(alert, animated: true, completion: nil)

      