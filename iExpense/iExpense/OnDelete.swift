//
//  OnDelete.swift
//  iExpense
//
//  Created by Kein Li on 12/10/23.
//

import SwiftUI

struct OnDelete: View {
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id : \.self) { number in
                        Text("\(number)")
                    }
                    .onDelete(perform: deleteFunc)
                }
                
                    
                Button("Add a number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .toolbar {
                EditButton()
        }
        }
    }
    
    func deleteFunc(indexSet : IndexSet){
        numbers.remove(atOffsets: indexSet)
    }
}

struct OnDelete_Previews: PreviewProvider {
    static var previews: some View {
        OnDelete()
    }
}
