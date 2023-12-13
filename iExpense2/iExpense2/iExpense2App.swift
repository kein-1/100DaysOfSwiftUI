//
//  iExpense2App.swift
//  iExpense2
//
//  Created by Kein Li on 12/11/23.
//

import SwiftUI

@main
struct iExpense2App: App {
    
    // Previously we used @StateObject, but now iwth this new macro @Observable, we use @State now
    // Once again @State preserves the object across view updates
    // However, I put it here so it is owned by the app rather than the view 
    @State private var expenses = Expenses()
    
    var body: some Scene {
        WindowGroup {
            ContentView(expenses: expenses)
        }
    }
}
