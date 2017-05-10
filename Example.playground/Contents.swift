//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
class Angle {
    
  
    
    var degrees: UnitAngle {
        
        get{
            return UnitAngle(symbol: "˚", converter: UnitConverterLinear(coefficient: 1))
            
        }
        
    }
    
    var arcMinutes: UnitAngle {
        
        get{
            return UnitAngle(symbol: "'", converter: UnitConverterLinear(coefficient: degrees.converter.baseUnitValue(fromValue: 1)/60))
        }
        
    }
    
    var arcSeconds: UnitAngle {
        
        get {
            return UnitAngle(symbol: "\"", converter: UnitConverterLinear(coefficient: arcMinutes.converter.baseUnitValue(fromValue: 1)/60))
            
        }
        
    }
    
    
}

var angle = Angle()
angle.degrees.symbol


