//
//  SecondViewController.swift
//  park calc
//
//  Created by Subu on 8/29/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: Program Variables
    var CurrentValue : Double = 10000.00
    var InterestRate: Double = 3.0 //this is a percentage
    var TimeinYears: Double = 5.0
    var compFreq: Character = "m"
    var FutureValue: Double?
    var SelectedMode: Character = "L" //lumpsum
    
    let step: Float = 50
    
    @IBOutlet weak var DisplayResults: UILabel!
    
    @IBOutlet weak var slideMoney: UISlider!
    
    //func not yet used in this module
    private func setSliderProperties(slidertype:Character){
        
        if slidertype == "L" {
        slideMoney.maximumValue = 1000000
        slideMoney.minimumValue = 100000
        slideMoney.value = 500000
        } else {
            
            slideMoney.maximumValue = 10000
            slideMoney.minimumValue = 500
            slideMoney.value = 250
        }
   
        CurrentValue = Double(String(format:"%.0f",slideMoney.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        
    }
    
    @IBAction func computeType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            SelectedMode = "P"
        default:
            SelectedMode = "L"
        }
        //ResetLabels()
        //setSliderProperties(slidertype: SelectedMode)
        
        Calculate()
    }

    // this func is deprecated
    private func ResetLabels(){
        //reset labels to show proper description
        if SelectedMode == "F" {
            
            DisplayLblCaption.text = "annuity future value"
          
            
        } else {
            
            DisplayLblCaption.text = "annuity present value"
         
            
            
        }
    }
    
    @IBOutlet weak var DisplayLblCaption: UILabel!
    @IBOutlet weak var interestRateLbl: UILabel!
    
    @IBOutlet weak var DisplayComputedValue: UILabel!
    
    @IBOutlet weak var currentInvestmentLbl: UILabel!
    
    @IBAction func currentInvestment(_ sender: UISlider) {
        
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        CurrentValue = Double(String(format:"%.0f",sender.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        Calculate()

    }
    
    @IBAction func interestRate(_ sender: UISlider) {
        
        interestRateLbl.text = "\(String(format:"%.1f",sender.value))%"
        
        InterestRate = Double(String(format:"%.1f",sender.value))!
        
        Calculate()
    }
    
    @IBOutlet weak var timeinYearsLbl: UILabel!
    
    @IBAction func timeinYears(_ sender: UISlider) {
        
        timeinYearsLbl.text = "\(String(format:"%.0f",sender.value))"
        
        TimeinYears = Double(String(format:"%.0f",sender.value))!
        
        Calculate()
        
    }
    
  
    
    
    @IBAction func compoundingFrequency(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            compFreq = "m"
        case 1:
            compFreq = "h"
        case 2:
            compFreq = "y"
        default:
            compFreq = "n"
        }
        Calculate()

    }
    
    func Calculate() {
        DisplayComputedValue.text = "Calculating.."
        
        var cc = CashFlowEngine()
        
        if SelectedMode == "L" {
            
             DisplayComputedValue.text = formatCurrency(value: cc.ComputePresentValue(futureValue: CurrentValue,  interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            
    
            
            DisplayResults.text = "To achieve the goal of  \(formatCurrency(value:CurrentValue)), invest a lumpsum of  \(DisplayComputedValue.text!) for \(TimeinYears) years. moni gets compounded  \(getCompoundingFrequencyDesc(value:compFreq)) at \(InterestRate)% "
            
          
        } else {
            
           
            DisplayComputedValue.text = formatCurrency(value: cc.ComputeAnnuityGivenFutureValue(futureValue: CurrentValue,  interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            
            DisplayResults.text = "To achieve the goal of  \(formatCurrency(value:CurrentValue)), invest  \(DisplayComputedValue.text!) \(getCompoundingFrequencyDesc(value:compFreq)) compounded at \(InterestRate)% for \(TimeinYears) years"
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Calculate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

