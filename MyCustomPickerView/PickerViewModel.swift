//
//  PickerViewModel.swift
//  Demo
//
//  Created by ZhuXueliang on 15/10/15.
//  Copyright © 2015年 IOSSOCKET. All rights reserved.
//

import UIKit

class PickerViewModel: NSObject {
    
    var degree: [Int]!
    var minutes: [Int]!
    var seconds: [Int]!
    
    init(degree: [Int],minutes: [Int], seconds: [Int]) {
        self.degree = degree
        self.minutes = minutes
        self.seconds = seconds
        
    }
    
    deinit {
        print("Экземпляр класса PickerViewModel удален из оперативной памяти")
    }
}


