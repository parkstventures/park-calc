//
//  ThirdViewController.swift
//  park calc
//
//  Created by Subu on 8/29/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    //MARK: Program Variables
    var CurrentValue : Double = 10000.00
    var InterestRate: Double = 3.0 //this is a percentage
    var TimeinYears: Double = 5.0
    var compFreq: Character = "m"
    var FutureValue: Double?
    var SelectedMode: Character = "F" //future value
    
    let step: Float = 500
    
    @IBOutlet weak var DisplayResults: UILabel!
    
    @IBOutlet weak var DisplayComputedValue: UILabel!
    
    @IBAction func computeType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            SelectedMode = "P"
        default:
            SelectedMode = "F"
        }
        ResetLabels()
        Calculate()
        
    }
    
    @IBOutlet weak var CapitalLblCaption: UILabel!
    private func ResetLabels(){
        //reset labels to show proper description
        if SelectedMode == "F" {
            
            
            CapitalLblCaption.text = "present value"
            
        } else {
            
            
            CapitalLblCaption.text = "future value"
            
            
        }
    }
    
    @IBOutlet weak var currentInvestmentLbl: UILabel!
    
    @IBAction func currentInvestment(_ sender: UISlider) {
        
        //currentInvestmentLbl.text = "$\(String(format:"%.0f",sender.value))"
        
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        
        CurrentValue = Double(String(format:"%.0f",sender.value))!
        
        currentInvestmentLbl.text = formatCurrency(value: CurrentValue)
        
        Calculate()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var interestRateLbl: UILabel!

    @IBAction func InterestRate(_ sender: UISlider) {
        
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
        
        if SelectedMode == "F" {
            
            DisplayComputedValue.text = formatCurrency(value:
                cc.ComputeAnnuityGivenPresentValue(presentValue: CurrentValue,  interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            //MARK: TOdo: Check
             DisplayResults.text = "To achieve a value of \(formatCurrency(value:CurrentValue)) in future, you should invest \(DisplayComputedValue.text!) regularly  \(getCompoundingFrequencyDesc(value:compFreq)) at the \(InterestRate)% for \(TimeinYears) years"
            
        } else {
            
            DisplayComputedValue.text = formatCurrency(value:cc.ComputeAnnuityGivenFutureValue(futureValue:  CurrentValue, interestRate: InterestRate, timePeriod: TimeinYears, compFreq: compFreq))
            
            DisplayResults.text = "To achieve a value of \(formatCurrency(value:CurrentValue)) in future, you should invest \(DisplayComputedValue.text!) regularly  \(getCompoundingFrequencyDesc(value:compFreq)) at the \(InterestRate)% for \(TimeinYears) years"
            
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
