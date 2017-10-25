//
//  FirstViewController.swift
//  park calc
//
//  Created by Subu on 8/29/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    //MARK: Program Variables
    var CurrentValue : Double = 10000.00
    var InterestRate: Double = 3.0 //this is a percentage
    var TimeinYears: Double = 5.0
    var compFreq: Character = "m"
    var FutureValue: Double?
    var SelectedMode: Character = "L" //lumpsum
    
    @IBOutlet weak var DisplayResults: UILabel!
    
    @IBOutlet weak var slideMoney: UISlider!
    
    let step: Float = 500
    
    private func setSliderProperties(slidertype:Character){
        
        if slidertype == "L" {
            slideMoney.maximumValue = 1000000
            slideMoney.minimumValue = 5000
            slideMoney.value = 50000
        } else {
            
            slideMoney.maximumValue = 5000
            slideMoney.minimumValue = 50
            slideMoney.value = 250
        }
        
        CurrentValue = Double(String(format:"%.0f",slideMoney.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        
    }
    
    
    @IBOutlet weak var DisplayComputedValue: UILabel!
    
    
    
    @IBOutlet weak var currentInvestmentLbl: UILabel!
    
    @IBAction func currentInvestment(_ sender: UISlider) {
        
        //currentInvestmentLbl.text = "$\(String(format:"%.0f",sender.value))"
        
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        CurrentValue = Double(String(format:"%.0f",sender.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        Calculate()
        
    }
    
    @IBAction func ComputeType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            SelectedMode = "P"
        default:
            SelectedMode = "L"
        }
        //ResetLabels()
        setSliderProperties(slidertype: SelectedMode)
        Calculate()
        
    }
    
    @IBOutlet weak var CapitalLblCaption: UILabel!
    @IBOutlet weak var DisplayLblCaption: UILabel!
   
    // this function is deprecated
    private func ResetLabels(){
        //reset labels to show proper description
        if SelectedMode == "F" {
            
            DisplayLblCaption.text = "future value"
            CapitalLblCaption.text = "present value"
            
        } else {
            
            DisplayLblCaption.text = "present value"
            CapitalLblCaption.text = "future value"

            
        }
    }
    
    @IBOutlet weak var interestRateLbl: UILabel!
    
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
           
            DisplayComputedValue.text = formatCurrency(value: cc.ComputeFutureValue(presentValue: CurrentValue, interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            DisplayResults.text = "Your lumpsum investment of  \(formatCurrency(value:CurrentValue)) compounded \(getCompoundingFrequencyDesc(value:compFreq)) at \(InterestRate)% will yield \(DisplayComputedValue.text!) in \(TimeinYears) years. Total interest: \(formatCurrency(value:(cc.TotalInterest)))"
        } else {
            
           DisplayComputedValue.text = formatCurrency(value: cc.ComputeFutureValueGivenAnnuity(annuity:  CurrentValue, interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            
            DisplayResults.text = "Your \(getCompoundingFrequencyDesc(value:compFreq)) investment of  \(formatCurrency(value:CurrentValue)) compounded at \(InterestRate)%  will yield \(DisplayComputedValue.text!) in \(TimeinYears) years. Total investment: \(formatCurrency(value:(cc.TotalCapital))); Total interest: \(formatCurrency(value:(cc.TotalInterest)))"
            
        
            
        }
        
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //reset the label
        Calculate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

