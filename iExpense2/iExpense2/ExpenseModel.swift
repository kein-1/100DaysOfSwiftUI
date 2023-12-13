//
//  ExpenseModel.swift
//  iExpense2
//
//  Created by Kein Li on 12/12/23.
//

import Foundation
import SwiftUI
import Observation

// Use Observable. Previously we had to use @ObservableObject for classes and @Published
// for the changes in that class
// Now, all we need to do is use @Observable
@Observable
class Expenses {
    
    var items = [ExpenseItem]() {
        didSet { // runs code here after a change, so anytime something is updated or removed
            encode()
        }
    }
    
    
    
    var business : [ExpenseItem] {
        items.filter { item in
            item.type == "Business"
        }
    }
    
    var personal : [ExpenseItem] {
        items.filter { item in
            item.type == "Personal"
        }
    }
    
    let categories = ["Food", "Travel", "Education", "Household", "Misc"]

    // Sort expenses by their category type
    var personalPerCategory : [String : Double] {
        let dict : [String : Double] = items.reduce(into: [:]) { result, expense in
            let key = expense.category
            return result[key, default: 0.0] += expense.amount
        }
        print(dict)
        return dict
    }
    
    var foodTotal : Double {
        items.reduce(0) { sum, expense in
            sum + (expense.category == "Food" ? expense.amount : 0)
        }
    }
    
    var travelTotal : Double {
        items.reduce(0) { sum, expense in
            sum + (expense.category == "Travel" ? expense.amount : 0)
        }
    }
    
    var educationTotal : Double {
        items.reduce(0) { sum, expense in
            sum + (expense.category == "Education" ? expense.amount : 0)
        }
    }
    
    var householdTotal : Double {
        items.reduce(0) { sum, expense in
            sum + (expense.category == "Household" ? expense.amount : 0)
        }
    }
    
    var miscTotal : Double {
        items.reduce(0) { sum, expense in
            sum + (expense.category == "Misc" ? expense.amount : 0)
        }
    }
    
    
    let key = "Expenses"
    
    init(){
//        UserDefaults.standard.removeObject(forKey: key)

        // retrieve the item at the given key
        if let savedExpenses = UserDefaults.standard.data(forKey: "Expenses"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedExpenses) {
                items = decodedItems
                return
            }
        } else {
            items = []
        }
    }
    
    
    // JSONEnconder encodes our items to a type Data and saves it
    // We need to decode this data type later
    // Here, it is saved under the key "Expenses"
    func encode(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
