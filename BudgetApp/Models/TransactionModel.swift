//
//  TransactionModel.swift
//  BudgetApp
//
//  Created by Dylan Caetano on 10/03/2025.
//

import Foundation

struct TransactionModel: Identifiable, Hashable {
    
    let id = UUID()
    let title: String
    let type: TransactionTypeModel
    let amount: Double
    let date: Date
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}

//extension TransactionModel: Hashable {
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//}
