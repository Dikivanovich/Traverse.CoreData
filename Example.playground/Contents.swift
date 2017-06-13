//: Playground - noun: a place where people can play

import UIKit

var textDecimal: String?






NumberFormatter().currencyDecimalSeparator = ","
var local = Locale(identifier: "ru_Ru")
local.localizedString(forIdentifier: "ru")
local.localizedString(forRegionCode: "ru")
local.decimalSeparator
var prob = NSDecimalNumber(string: textDecimal).decimalValue

