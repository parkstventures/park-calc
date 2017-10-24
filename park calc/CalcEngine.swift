

//
//  CalcEngine.swift
//  Park Calc
//
//  Created by Subu on 7/28/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import Foundation

enum InterestFrequency : Double {
    case monthly = 12.0
    case yearly = 1.0
    case halfyearly = 2.0
    case nocompounding = 0.0
}

struct CalcEngine {
    
    
    //MARK: Variables
    
    private var fvInitialCapital: Double = 0.0
    private var fvRecurringCapital: Double? //
    
    
    private var interest: Double = 5.0
    private var timeinYears: Double = 1.0
    private var compFreq: Character = "m"
    
    private var initialCapital: Double = 0.0
    private var interestInitialCapital: Double = 0.0
    
    //These are optional as they may or may not be used
    private var recurringCapital: Double?
    private var totalRecurringCapital: Double? // since recurring capital is for one time period, the total is in this bucket
    private var interestRecurringCapital: Double?
    
    mutating func computePV(futureValue f: Double, rate r: Double, time t: Double, frequency q: Character) {
        
        fvInitialCapital = f
        interest = r
        timeinYears = t
        compFreq = q
        
        let step1 = powerNumber(first: interest, secondS: timeinYears)
        
        //here we compute both ways assuming either one can be used but not both
        initialCapital = fvInitialCapital / step1
        totalRecurringCapital = fvInitialCapital * (interest / (CompoundingFrequency * 100)) / ( step1 - 1)
        
        recurringCapital = totalRecurringCapital! / ( timeinYears * CompoundingFrequency)
        
        interestInitialCapital = fvInitialCapital - initialCapital
        interestRecurringCapital = fvInitialCapital - recurringCapital! * timeinYears * CompoundingFrequency
        
        
    }
    
    mutating func computeFV(presentValue p: Double, additionalAmount a: Double, rate r: Double, time t: Double, frequency f: Character) {
        
        initialCapital = p
        recurringCapital = a
        interest = r
        timeinYears = t
        compFreq = f
        
        if ( CompoundingFrequency == InterestFrequency.nocompounding.rawValue) {
            
            //let step2 = 1 + (interest * timeinYears / 100)
            
            fvInitialCapital = initialCapital * (1 + (interest * timeinYears / 100))
            
            interestInitialCapital = fvInitialCapital - initialCapital
            
            totalRecurringCapital = recurringCapital!  * timeinYears
            
            fvRecurringCapital =  recurringCapital! * (1 + (interest * timeinYears / 100))
            
            interestRecurringCapital = fvRecurringCapital! - totalRecurringCapital!
            
            
        } else {
            
            let step1 = powerNumber(first: interest, secondS: timeinYears)
            
            fvInitialCapital = initialCapital * step1
            
            interestInitialCapital = fvInitialCapital - initialCapital
            
            totalRecurringCapital = recurringCapital! * timeinYears * CompoundingFrequency
            
            fvRecurringCapital =  (step1 - 1 ) * a / (interest / (100 * CompoundingFrequency))
            
            interestRecurringCapital = fvRecurringCapital! - totalRecurringCapital!
        }
    }
    
    private func powerNumber(first: Double, secondS: Double) -> Double{
        
        return pow((1.0 + (first / (CompoundingFrequency * 100))), secondS * CompoundingFrequency)
        
        
    }
    
    // we are using three ways to unwrap an optional
    
    var TotalCapital: Double {
        get {
            if let rC = recurringCapital {
                return initialCapital + rC
            } else {
                return initialCapital
            }
        }
    }
    
    var TotalInterest: Double {
        get {
            return InterestInitialCapital + InterestRecurringCapital
        }
        
    }
    
    var TotalFutureFV: Double {
        get {
            
            let rC: Double  = fvRecurringCapital ?? 0
            
            return rC + fvInitialCapital
        }
    }
    
    
    var InterestRecurringCapital: Double {
        get {
            if interestRecurringCapital != nil {
                return  interestRecurringCapital!
            } else {
                return 0.0
            }
            
            
        }
    }
    
    var InterestInitialCapital: Double {
        get {
            return interestInitialCapital
        }
    }
    
    
    var InitialCapital: Double {
        get {
            return initialCapital
        }
        set(newInitialCapital){
            initialCapital = newInitialCapital
        }
    }
    
    var TotalRecurringCapital: Double {
        get {
            if let rC = totalRecurringCapital {
                return rC
            } else {
                return 0
            }
        }
    }
    
    var RecurringCapital: Double {
        get {
            if  recurringCapital != nil {
                return recurringCapital!
            } else {
                return 0
            }
        }
        set(newRecurringCapital){
            recurringCapital = newRecurringCapital
        }
    }
    
    var FVInitialCapital : Double {
        get {
            return fvInitialCapital
        }
        
        set(newFVInitialCapital) {
            fvInitialCapital = newFVInitialCapital
        }
    }
    
    var FVRecurringCapital: Double {
        get {
            if fvRecurringCapital != nil {
                return fvRecurringCapital!
            } else {
                return 0.0
            }
        }
    }
    
    /* deprecate these */
    
    var PVLumpsum: Double {
        get {
            return initialCapital
        }
    }
    
    var PVMonthly: Double {
        get {
            if recurringCapital != nil {
                return recurringCapital!
            } else {
                return 0.0
            }
        }
    }
    
    var FV: Double {
        get {
            return fvInitialCapital
        }
    }
    
    /* supporting function */
    
    private var CompoundingFrequency: Double{
        get {
            switch compFreq {
            case "m": //monthly
                return InterestFrequency.monthly.rawValue
                
            case "y": //yearly
                return InterestFrequency.yearly.rawValue
                
            case "h" : // half - yearly
                return InterestFrequency.halfyearly.rawValue
                
            default:
                return InterestFrequency.nocompounding.rawValue
                
                
            }
        }
    }
    
}

