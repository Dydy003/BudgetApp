//
//  TransactionTypeModel.swift
//  BudgetApp
//
//  Created by Dylan Caetano on 10/03/2025.
//

import Foundation

enum TransactionTypeModel: String, CaseIterable, Identifiable {
    case income, expence
    var id: Self { self }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expence:
            return "Expence"
        }
    }
}
