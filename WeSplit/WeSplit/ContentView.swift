//
//  ContentView.swift
//  WeSplit
//
//  Created by Kein Li on 11/17/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var peopleCount = 1
    @State private var tipPercent = 0
    @FocusState private var focused : Bool // mostly used for focus/textfields. don't need to assign a value to it b/c we use @FocusState
    
    // Computed property
    var totalCheckAmount : Double {
        checkAmount  + Double(tipPercent) / 100 * checkAmount
    }
    
    var totalPerPerson : Double {
        totalCheckAmount/Double(peopleCount)
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    HStack {
                        Text("Enter Amount: ")
                        TextField("", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .multilineTextAlignment(.trailing) // right aligns!
                            .keyboardType(.decimalPad)
                            .focused($focused) // focus here is true if focuseed, otehrwise false
                    }
                }
                Section {
                    // No need to add a .tag after text since ForEach inside picker uses the id to assign it to selection
                    Picker("Number of People: ", selection: $peopleCount) {
                        ForEach(1..<21, id : \.self){ numb in
                            Text("Count : \(numb)")
                        }
                    }
                    
                }
                Section("How much tip?") {
                    Picker("Tip:", selection: $tipPercent){
                        ForEach(0..<101, id: \.self){ tip in
                            Text(tip, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    HStack{
                        Text("Grand Total : ")
                        Spacer()
                        Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            
                    }
                    HStack{
                        Text("Total Per Person: ")
                        Spacer()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    
                    Button("clcik") {
                        print(focused)
                        focused.toggle()
                    }
                }
                
                Section {
                    
                    HStack {
                        Spacer()
                        Button("Reset") {
                            checkAmount = 0
                            peopleCount = 1
                            tipPercent = 0
                        }
                        .buttonStyle(.plain)
                        .cornerRadius(10)
                    }
                }
            }
            .tint(.blue)
            .navigationTitle("Tip App")
            .toolbar{ // toolbar used to get out of focued state. will only run if focused is true
                if focused {
                    Button("Done") {
                        focused = false
                    }
                }
            }
            .padding(.top)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
