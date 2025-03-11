//
//  HomeView.swift
//  BudgetApp
//
//  Created by Dylan Caetano on 10/03/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions: [TransactionModel] = []
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionModel?
    
    private var expenses: String {
        let sumExpenses = transactions.filter({ $0.type == .expence}).reduce(0, { $0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "$0.00"
    }
    
    private var incom: String {
        let sumIncome = transactions.filter({ $0.type == .income}).reduce(0, { $0 + $1.amount})
//        for transaction in transactions {
//            if transaction.type == .income {
//                sumIncome += transaction.amount
//            }
//        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "$US0.00"
    }
    
    private var total: String {
        let sumExpenses = transactions.filter({ $0.type == .expence}).reduce(0, { $0 + $1.amount})
        let sumIncome = transactions.filter({ $0.type == .income}).reduce(0, { $0 + $1.amount})
        let total = sumIncome - sumExpenses
//        for transaction in transactions {
//            switch transaction.type {
//            case .income:
//                total += transaction.amount
//                
//            case .expence:
//                total -= transaction.amount
//            }
//        }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "$US0.00"
    }
    
    fileprivate func FloathingButton() -> some View {
        VStack {
            
            Spacer()
            
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 50))
                    .foregroundStyle(Color.blueShade)
            }.padding(.horizontal)
            .padding(.top)
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blueShade)
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(Color.white)
                        
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(Color.white)
                    }
                    
                    Spacer()
                    
                }.padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Text("\(incom)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(Color.white)
                    }
                }
                
                Spacer()
                
            }.padding(.horizontal)
        }
        .shadow(color: Color.blueShade.opacity(0.3), radius: 10, x: 0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .trailing) {
                VStack {
                    BalanceView()
                    List {
                        ForEach(transactions) { transaction in
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        }.onDelete(perform: delete)
                    }.scrollContentBackground(.hidden)
                }
                FloathingButton()
            }.navigationTitle("BudgetApp")
            
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions, transactionToEdit: transactionToEdit)
                })
            
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                    AddTransactionView(transactions: $transactions)
                })
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "gear.circle.fill")
                            .foregroundStyle(Color.blueShade)
                    })
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
}
