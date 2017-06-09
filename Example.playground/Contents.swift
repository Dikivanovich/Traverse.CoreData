//: Playground - noun: a place where people can play

import UIKit
var separate = NumberFormatter().currencyDecimalSeparator
var textDecimal = "3.312"




var prob = NSDecimalNumber(string: textDecimal).stringValue
var prob1 = NumberFormatter().number(from: textDecimal)