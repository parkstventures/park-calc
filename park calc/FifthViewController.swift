//
//  FifthViewController.swift
//  park calc
//
//  Created by Subu on 9/19/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

 //MARK: Program Variables
 var CurrentValue : Double = 2000.00
 var TimeinYears: Double = 10.0
 var compFreq: Character = "m"
 var FutureValue: Double = 20000.00
 //var SelectedMode: Character = "F" //future value
 
    @IBOutlet weak var DisplayResults: UILabel!
    let step: Float = 500
    
    
    @IBOutlet weak var DisplayComputedValue: UILabel!
 
    @IBOutlet weak var currentInvestmentLbl: UILabel!
    @IBAction func currentInvestment(_ sender: UISlider) {
        
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        CurrentValue = Double(String(format:"%.0f",sender.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        Calculate()
    }

    @IBOutlet weak var futureInvestmentLbl: UILabel!
    
    @IBAction func futureInvestment(_ sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        FutureValue = Double(String(format:"%.0f",sender.value))!
        
        futureInvestmentLbl.text = formatCurrency(value: FutureValue)
        
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
            compFreq = "m"
        }
        Calculate()
        
    }
    func Calculate() {
        DisplayComputedValue.text = "Calculating.."
        
        var cc = CashFlowEngine()
        
        DisplayComputedValue.text =
            DisplayFormatPercent(data: cc.ComputeInterestRate(presentValue: CurrentValue, futureValue: FutureValue, timePeriod: TimeinYears, compFreq: compFreq))
        
        DisplayResults.text = "Your invesment of \(formatCurrency(value:CurrentValue)) will grow to  \(formatCurrency(value:FutureValue)) in \(TimeinYears) years if the interest rate is \(DisplayComputedValue.text!)% compounded \(getCompoundingFrequencyDesc(value:compFreq))"
        
        
    }

    
}
