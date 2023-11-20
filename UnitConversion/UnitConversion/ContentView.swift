//
//  ContentView.swift
//  UnitConversion
//
//  Created by Kein Li on 11/18/23.
//

import SwiftUI


// String so we can assign raw values, CaseIterable so we can loop through all the enum cases later
enum UnitTypes: String, CaseIterable {
        
    case currency = "Currency"
    case length = "Length"
//    case temperature = "Temperature"
//    case time = "Time"
}

enum SubUnitTypes : String, CaseIterable {
    case usd = "USD"
    case jpy = "JPY"
    case cad = "CAD"
    case inches = "Inches"
    case meter = "Meter"
    case kilometer = "Kilometer"
    case feet = "Feet"
    
    var conversionVal : Int {
        switch self {
        case .usd, .jpy, .cad :
            return 1
        case .inches, .meter, .kilometer, .feet:
            return 2
        }
    }
}

let unitDict : [UnitTypes : [SubUnitTypes]] = [
    UnitTypes.currency : [.usd,.jpy,.cad],
    UnitTypes.length : [.inches,.meter,.kilometer,.feet]]

// Base units : USD for currency, Inches for length
// If we have CAD to JPY : CAD returns 0.76 USD.
let conversionDict : [String : Double] = [
    "USD" : 1.0,
    "JPY" : 0.0091,
    "CAD" : 0.76,
    "Inches" : 1.0,
    "Meter" : 39.37,
    "Feet" : 12,
    "Kilometer" : 39370.1

]



struct ContentView: View {
    
    @State private var currentUnitSelection : UnitTypes = UnitTypes.currency
    @State private var fromUnit : SubUnitTypes = SubUnitTypes.cad
    @State private var toUnit : SubUnitTypes = SubUnitTypes.usd
    
    @State private var inputVal = ""
    @State private var outputVal = ""
    
    private var inputDouble : Double {
        return Double(inputVal) ?? 0.0
    }
    
    private var selectedSubArr : [SubUnitTypes] {
        return unitDict[currentUnitSelection]!
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Selection: ", selection: $currentUnitSelection) {
                        ForEach(UnitTypes.allCases, id : \.self) { types in
                            Text(types.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    VStack{
                        Picker("", selection: $fromUnit) {
                            ForEach(selectedSubArr, id : \.self) { val in
                                Text(val.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    TextField("Enter input: ", text: $inputVal)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Picker("", selection: $toUnit) {
                        ForEach(selectedSubArr, id : \.self) { val in
                            Text(val.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    Button("convert") {
                        outputVal = conversion(fromUnit,toUnit,inputDouble)
                    }
                   
                    Button("test") {
                        print(selectedSubArr)
                        print(fromUnit.rawValue + " " + toUnit.rawValue)
                    }
                    
                    Text(outputVal)
                }
               
            }
        }
        .padding()
        
    }
}

func conversion (_ from : SubUnitTypes , _ to : SubUnitTypes, _ inputVal : Double) -> String {
    
    // Use guard to unwrap. Return if either is invalid
    guard let val1 = conversionDict[from.rawValue], let val2 = conversionDict[to.rawValue] else {
        return ""
    }
    
    if val1 == val2 {
        return String(inputVal)
    }
    
    var intVal1 = from.conversionVal
    var result = inputVal * val1 / val2
    return String(result)
    
//    switch intVal {
//        // Means currency, so convert from to the base type
//    case 1 :
//
//
//        // Means units
//    case 2 :

//    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
