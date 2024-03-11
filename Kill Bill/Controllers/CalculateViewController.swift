//
//  ViewController.swift
//  Kill Bill
//
//  Created by Srijnasri Negi on 11/03/24.
//

import UIKit

enum TipConstants {
    static let zeroPercentTip = "0%"
    static let tenPercentTip = "10%"
    static let twentyPercentTip = "20%"
}

class CalculateViewController: UIViewController {
    @IBOutlet weak var billText: UITextField!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tip1Button: UIButton!
    @IBOutlet weak var tip2Button: UIButton!
    @IBOutlet weak var tip3Button: UIButton!
    @IBOutlet weak var splitStepper: UIStepper!
    
    var splitBill = SplitBill()
    var tip: Float?
    var billSplitValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tip1Button.isSelected = false
        tip2Button.isSelected = false
        tip3Button.isSelected = false
        billText.keyboardType = .decimalPad
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func calculatePressed(_ sender: UIButton) {
        if let billAmount = billText.text {
            if  let tipPercent = tip {
                billSplitValue = splitBill.calculateBillSplit(bill: Bill(billValue: billAmount,
                                                                         splitValue: splitStepper.value,
                                                                         tipPercent: tipPercent))
                self.performSegue(withIdentifier: Constants.goToResultVC, sender: self)
            } else {
                billSplitValue = splitBill.calculateBillSplit(bill: Bill(billValue: billAmount,
                                                                         splitValue: splitStepper.value,
                                                                         tipPercent: nil))
                self.performSegue(withIdentifier: Constants.goToResultVC, sender: self)
            }
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        billText.endEditing(true)
        splitLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billText.endEditing(true)
        tip = setTipButtons(buttonSelected: sender.currentTitle!)
    }
    
    func setTipButtons(buttonSelected: String) -> Float {
        switch buttonSelected {
        case TipConstants.zeroPercentTip:
            tip1Button.isSelected = true
            tip2Button.isSelected = false
            tip3Button.isSelected = false
            return 0.0
        case TipConstants.tenPercentTip:
            tip1Button.isSelected = false
            tip2Button.isSelected = true
            tip3Button.isSelected = false
            return 0.1
        case TipConstants.twentyPercentTip:
            tip1Button.isSelected = false
            tip2Button.isSelected = false
            tip3Button.isSelected = true
            return 0.2
        default:
            debugPrint("invalid choice")
            return 0.0
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.totalValue = billSplitValue
        destinationVC.split = splitStepper.value
        destinationVC.tip = tip ?? 0 * 100
    }
}
