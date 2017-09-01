//: Playground - noun: a place where people can play

import UIKit

let url = URL(fileURLWithPath: "/Volumes/Data/Users/Dik/Desktop/30KAT.txt")


let encoding = String.Encoding.utf8.rawValue

do {

    let text = try NSString(contentsOf: url, encoding: encoding)

} catch  {
    print(error)
}







