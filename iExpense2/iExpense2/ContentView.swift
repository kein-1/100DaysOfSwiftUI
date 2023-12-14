//
//  ContentView.swift
//  iExpense2
//
//  Created by Kein Li on 12/11/23.
//

import SwiftUI
import Observation

struct ExpenseItem: Identifiable, Codable {
    let name : String
    let type : String
    let amount : Double
    let category : String
    let date : Date
    var icon : String {
        switch category {
        case "Food" :
            return "takeoutbag.and.cup.and.straw"
        case "Travel" :
            return "car"
        case "Education" :
            return "graduationcap"
        case "Household":
            return "house"
        case "Misc":
            return "questionmark.app"
        default:
            return ""
        }
    }
    
    var id = UUID()
}


//The rules for closure labelling are:
//
//Label of the first trailing closure is omitted.
//Labels of subsequent closures are required.

struct ContentView: View {
    // Previously we used @StateObject, but now iwth this new macro @Observable, we use @State now
    // Once again @State preserves the object across view updates
    var expenses : Expenses
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack{
                
            ChartView(expenses: expenses.personalPerCategory)
            
            List {
                Section {
                    ForEach(expenses.personal, id: \.id){ expense in
                        
                        ExpenseView(expense: expense)
                    }
                    .onDelete(perform: delete)
                } header: {
                    Text("Recent Transactions")
                }
                
                

                // Key note : onDelete only in ForEach. ForEach handles passing the index of the current row
                // we want to delete to the indexSet which is then called to delete that row.
                // .onDelete requires a closure or a function. If closure, can omit labels
                // Since we use function, we need to specify label
                // notice perform takes in a closure or a function that has IndexSet as argument
                // so we can specify a closure or function
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem {
                    Button("Add Expense", systemImage: "plus") {
                        showAdd.toggle()
                    }
                }
            }
            // Pass the expens to AddView
            .sheet(isPresented: $showAdd){
                AddView(expenses: expenses)
            }
        }
    }
    
   
    
    func delete(indexSet : IndexSet){
        expenses.items.remove(atOffsets: indexSet)
    }
}


struct ExpenseView : View {
    var expense : ExpenseItem
    
    
    var body: some View {
        HStack {
            VStack {
                
                Label(expense.name, systemImage: expense.icon)
            }
            Spacer()
            VStack(alignment: .trailing) {
                
                Text(expense.amount, format: .currency(code: "USD"))
                Text(expense.date, format: Date.FormatStyle(date: .abbreviated, time: .omitted))
                    .font(.caption)
            }
        }
    }
}


#Preview {
    let previewExpenses = Expenses() // Create a preview instance - this is diff fro mthe one created in the main app
    return ContentView(expenses: previewExpenses)
}
