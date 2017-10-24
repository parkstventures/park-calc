//
//  CashFlowCalc.swift
//  park calc
//
//  Created by Subu on 9/1/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import Foundation

enum CompoundingFrequency : Double {
    case monthly = 12.0
    case yearly = 1.0
    case halfyearly = 2.0
    case nocompounding = 12.001 //setting no compounding to monthly
}


struct CashFlowEngine {
    
    //MARK: Variables
    private var PVCapital: Double = 0.0
    private var FVCapital: Double = 0.0
    private var AnnuityPayment: Double = 0.0
    private var InterestRate: Double = 0.0
    private var TimePeriod: Double = 0.0
    private var CompFreq: Character = "m" //equivalent to monthly compounding
    private var Annuity: Double = 0.0
    
    private var totalCapital: Double = 0.0
    private var totalInterest: Double = 0.0
    
    
    
    //function to calc future value given present value
    mutating func ComputeFutureValue(presentValue pv: Double,
                            interestRate r: Double,
                            timePeriod t: Double,
                            compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        PVCapital = pv
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            FVCapital = PVCapital * OnePlusRN()
            
        } else {
        FVCapital = PVCapital * OnePlusRPowerN()
        }
        
        totalCapital = PVCapital
        totalInterest = FVCapital - PVCapital
        
    
        
        return FVCapital
    }
    
    
    //function to calc present value given future value
    mutating func ComputePresentValue(futureValue fv: Double,
                                     interestRate r: Double,
                                     timePeriod t: Double,
                                     compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        FVCapital = fv
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            PVCapital = FVCapital / OnePlusRN()
            
        } else {
        PVCapital = FVCapital / OnePlusRPowerN()
        }
        
        return PVCapital
    }
    
    
    //function to calc future value given annuity
    mutating func ComputePresentValueGivenAnnuity(annuity an: Double,
                                      interestRate r: Double,
                                      timePeriod t: Double,
                                      compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        Annuity = an
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            //this is incorrect. needs to be checked
            FVCapital = Annuity / OnePlusRN()
            
        } else {
            FVCapital = Annuity * ( 1 - (1 / OnePlusRPowerN())) / InterestRate
        }
        
        return FVCapital
    }
    

    //function to calc present value given annuity
    mutating func ComputeFutureValueGivenAnnuity(annuity an: Double,
                                                  interestRate r: Double,
                                                  timePeriod t: Double,
                                                  compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        Annuity = an
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            //this is incorrect. needs to be checked
            PVCapital = Annuity / OnePlusRN()
            
        } else {
            PVCapital = Annuity * ( OnePlusRPowerN() - 1) / InterestRate
        }
        
        totalCapital = Annuity * TimePeriod
        totalInterest = PVCapital - totalCapital
        
        return PVCapital
    }

    //function to calc annuity given present value
    mutating func ComputeAnnuityGivenPresentValue(presentValue pv: Double,
                                     interestRate r: Double,
                                     timePeriod t: Double,
                                     compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        PVCapital = pv
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            //incorrect
            Annuity =  PVCapital * OnePlusRN()
            
        } else {
            Annuity = PVCapital * InterestRate/(1 - (1 / OnePlusRPowerN()))
            

        }
        
        return Annuity
    }
    
    
    //function to calc present value given future value
    mutating func ComputeAnnuityGivenFutureValue(futureValue fv: Double,
                                      interestRate r: Double,
                                      timePeriod t: Double,
                                      compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        FVCapital = fv
        CompFreq = f
        InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        //calculate (1+r)^n ..the step that will be used by all
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            //incorrect
            Annuity = FVCapital / OnePlusRN()
            
        } else {
            Annuity = FVCapital * InterestRate / (OnePlusRPowerN() - 1)
        }
        
        return Annuity
    }
    
    //function to calc interest rate given present and future value
    mutating func ComputeInterestRate(presentValue pv:Double, futureValue fv: Double, timePeriod t: Double, compFreq f: Character)-> Double {
        
        //MARK: Assign Values
        FVCapital = fv
        PVCapital = pv
        CompFreq = f
        //InterestRate = ConvertInterestRate(r)
        TimePeriod = ConvertTimePeriod(t)
        //MARK: Calc intermediate steps
        
        let temp1 = FVCapital/PVCapital
        
        let temp2 = (pow(temp1, 1/TimePeriod))-1
        
        
        
        //var OnePlusR = OnePlusRPowerN()
        //MARK: Do the final calc
        if CompoundingFrequencyMultiple == CompoundingFrequency.nocompounding.rawValue {
            //incorrect
            InterestRate = 1.0 //incorrect. this needs to be fixed
            
        } else {
            InterestRate = temp2 * CompoundingFrequencyMultiple * 100      }
        
        return InterestRate
        
        
    }
    
    private func OnePlusRN () -> Double {
        
        //simple interest
        return (1.0 + (InterestRate * TimePeriod))
        
    }
    
    private func OnePlusRPowerN () -> Double {
        
        return pow((1.0 + InterestRate), TimePeriod)
        
    }
    
    private func ConvertTimePeriod(_ t: Double)->Double{
        return  t * CompoundingFrequencyMultiple
        
    }

    
    private func ConvertInterestRate(_ r: Double)->Double{
        return r/(100 * CompoundingFrequencyMultiple)
        
    }
    private var CompoundingFrequencyMultiple: Double{
        get {
            switch CompFreq {
            case "m": //monthly
                return CompoundingFrequency.monthly.rawValue
                
            case "y": //yearly
                return CompoundingFrequency.yearly.rawValue
                
            case "h" : // half - yearly
                return CompoundingFrequency.halfyearly.rawValue
                
            default:
                return CompoundingFrequency.nocompounding.rawValue
                
                
            }
        }
    }

    var TotalCapital: Double {
        
        get {
            return totalCapital
        }
    }
    
    var TotalInterest: Double {
        
        get {
            return totalInterest
        }
    }
    
    
}
