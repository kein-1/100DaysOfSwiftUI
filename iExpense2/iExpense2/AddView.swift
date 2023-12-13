//
//  AddView.swift
//  iExpense2
//
//  Created by Kein Li on 12/11/23.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var category  = "Food"
    
    @Environment(\.dismiss) var dismiss
    
    var expenses : Expenses
    
    let types = ["Business", "Personal"]
    let categories = ["Food", "Travel", "Education", "Household", "Misc"]
    
    var body: some View {
        NavigationStack {
            Form {
                
                Picker("Choose Expense Type", selection: $type) {
                    ForEach(types, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                
                Picker("Choose Expense Category", selection: $category){
                    ForEach(categories, id : \.self) { category in
                        Text(category).tag(category)
                    }
                }
                
                TextField("Expense Name :", text: $name)
                TextField("Expense Amount : ", value: $amount, format : .currency(code: "USD"))
                
            }
            
            .navigationTitle("Add Expense")
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        let newExpense = ExpenseItem(name: name, type: type, amount: amount, category: category)
                        expenses.items.append(newExpense)
                        
                        // automatically dismisses the current view using its
                        // environment variable
                        // also automatically sets the isPresented (here we used .sheet) for the .sheet() to false
                        
                        dismiss()
                        // other ways to dismiss :
                        // pass the binding variable to this view but
                        // this method is clearner since we don't need to pass stuff
                        // from parent->child
                    }
                }
            }
        }
    }
}

//#Preview {
//    AddView()
//}
