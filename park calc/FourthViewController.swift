//
//  FourthViewController.swift
//  park calc
//
//  Created by Subu on 9/1/17.
//  Copyright © 2017 park street ventures. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    @IBOutlet weak var DisplayHelpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let t1 = "This app helps calculate future value and current value of your investment. The use case for future value is college education. You can use..."
        
        DisplayHelpLabel.text = t1 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
