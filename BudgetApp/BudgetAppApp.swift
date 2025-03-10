//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Dylan Caetano on 10/03/2025.
//

import SwiftUI

@main
struct BudgetAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
