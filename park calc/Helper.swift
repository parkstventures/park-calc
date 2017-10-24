//
//  Helper.swift
//  park calc
//
//  Created by Subu on 8/29/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import Foundation

extension String {
    
    var doubleValue:Double? {
        return NumberFormatter().number(from:self)?.doubleValue
    }
    
    var integerValue:Int? {
        return NumberFormatter().number(from:self)?.intValue
    }
    
    var isNumber:Bool {
        get {
            let badCharacters = NSCharacterSet.decimalDigits.inverted
            return (self.rangeOfCharacter(from: badCharacters) == nil)
        }
    }
}

//formats a double to a string with two decimal places and appends a $ sign
func DisplayFormat (data: Double) -> String {
    
    return "$" + String(format:"%.2f",data)
}


//format as percentage
func DisplayFormatPercent (data: Double) -> String {
    
    return  String(format:"%.2f",data) + "%"
}

//formats a double to a proper US currency and returns a string
func formatCurrency(value: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    formatter.locale = Locale(identifier: Locale.current.identifier)
    let result = formatter.string(from: value as NSNumber)
    return result!
}

//function convert code to compounding frequency description
func getCompoundingFrequencyDesc(value:Character)->String{
    
    var temp1: String = "monthly"
    switch  value {
    case "m":
    temp1 = "monthly"
    case "h":
    temp1 = "half yearly"
    case "y":
    temp1 = "yearly"
    default:
    temp1 = "monthly"
    }
    return temp1
}

