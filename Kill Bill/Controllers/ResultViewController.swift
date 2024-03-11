//
//  ResultViewController.swift
//  Kill Bill
//
//  Created by Srijnasri Negi on 11/03/24.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    var totalValue: String?
    var split: Double?
    var tip: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = totalValue
        settingLabel.text = String(format: Constants.splitBillText, split!, tip!)
        // Do any additional setup after loading the view.
    }

    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
