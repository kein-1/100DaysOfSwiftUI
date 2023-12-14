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
    @State private var date = Date()
    
    
    @Environment(\.dismiss) var dismiss
    
    // This is the view model
    var expenses : Expenses
    
    let types = ["Business", "Personal"]
    let categories = ["Food", "Travel", "Education", "Household", "Misc"]
    
    let startingDate : Date = Calendar.current.date(from: DateComponents(year: 2022)) ?? Date.now
    let endDate : Date = Date.now
    
    var body: some View {
        NavigationStack {
            
            
            Form {
                
                DatePicker("Select a Date and Time", selection: $date, in: startingDate...endDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .accentColor(.red)
                        
                
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
                        let newExpense = ExpenseItem(name: name, type: type, amount: amount, category: category, date: date)
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

#Preview {
    let previewExpenses = Expenses() // Create a preview instance - this is diff fro mthe one created in the main app
    return AddView(expenses: previewExpenses)
}
