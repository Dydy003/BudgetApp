//
//  AddTransactionView.swift
//  BudgetApp
//
//  Created by Dylan Caetano on 10/03/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var transactions: [TransactionModel]
    
    @State private var amount = 0.0
    @State private var transactionTitle: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @State private var selectedTransaction: TransactionTypeModel = .expence
    
    var transactionToEdit: TransactionModel?
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Rectangle()
                .fill(Color(uiColor: UIColor.blueShade))
                .frame(height: 1.0)
                .padding(.horizontal, 30)
            
            Picker("Chosse Type", selection: $selectedTransaction) {
                ForEach(TransactionTypeModel.allCases) { transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            TextField("Title", text: $transactionTitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                guard transactionTitle.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more character long"
                    showAlert = true
                    return
                }
                
                let transaction = TransactionModel(
                    title: transactionTitle,
                    type: selectedTransaction,
                    amount: amount,
                    date: Date()
                )
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(of: transactionToEdit) else {
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    transactions.append(transaction)
                }
                
                dismiss()
                
            } label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(Color.blueShade)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 30)
            
            Spacer()
            
        }
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                transactionTitle = transactionToEdit.title
                selectedTransaction = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button(action: {
                
            }, label: {
                Text("Ok")
            })
        }
    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
