//
//  SplitBill.swift
//  Kill Bill
//
//  Created by Srijnasri Negi on 11/03/24.
//

import Foundation

struct SplitBill {
    var bill: Bill?
    
    mutating func calculateBillSplit(bill: Bill) -> String {
        self.bill = bill
        return String(((Float(bill.billValue) ?? 0) * (bill.tipPercent ?? 0)) / Float(bill.splitValue))
    }
}
