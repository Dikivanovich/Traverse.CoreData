//
//  Data.swift
//  Traverse.CoreData
//
//  Created by Dik on 15.05.17.
//  Copyright © 2017 Kantulaev Ruslan. All rights reserved.
//

import Foundation

class DataModel {
    
    class func getData() -> (PickerViewModel) {
        
        var itemForDegree = [Int]()
        var itemForMinutesAndSeconds = [Int]()
        
        for i in 0..<360000 {
            
            itemForDegree.append(i)
            
        }
        
        for i in 0..<60000 {
            itemForMinutesAndSeconds.append(i)
        }
        
        let dataPickerView = PickerViewModel(degree: itemForDegree, minutes: itemForMinutesAndSeconds, seconds: itemForMinutesAndSeconds)
        
        return dataPickerView
    }
    
    deinit {
        print("\n\(self)Экземпляр класса удален из оперативной памяти")
    }
    
}
