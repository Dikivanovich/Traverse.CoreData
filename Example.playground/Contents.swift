//: Playground - noun: a place where people can play

import UIKit

var arrray = [Int]()
var arr1 = [Int]()
var arr2 = [Int]()


for i in 1...10 {
    
    arrray.append(i)
    
}

arrray

var integer = Int()

for item in arrray {
    
    integer += 1
    
    if integer%2 == 0 {
        
        arr1.append(item)
    } else {
        
        arr2.append(item)
        
    }
    
    
}

integer
arr1
arr2

var indexSet = Int()
arrray.removeAll()

for i in arr1 {
    

    
    
    arrray.append(arr2[indexSet] - i)
    indexSet += 1
    
    
}

arrray


