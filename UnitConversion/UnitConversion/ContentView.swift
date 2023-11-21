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
    case temperature = "Temperature"
}

enum SubUnitTypes : String, CaseIterable {
    case usd = "USD"
    case jpy = "JPY"
    case cad = "CAD"
    case inches = "Inches"
    case meter = "Meter"
    case kilometer = "Kilometer"
    case feet = "Feet"
    case f = "Farenheit"
    case c = "Celcius"
    case k = "Kelvin"
    
    
    var conversionVal : Int {
        switch self {
        case .usd,.jpy,.cad :
            return 1
        case .inches, .meter, .kilometer, .feet :
            return 2
        case .f, .c, .k :
            return 3
        }
    }
}

let unitDict : [UnitTypes : [SubUnitTypes]] = [
    UnitTypes.currency : [.usd,.jpy,.cad],
    UnitTypes.length : [.inches,.meter,.kilometer,.feet],
    UnitTypes.temperature : [.f,.c,.k]
]

// Base units : USD for currency, Inches for length
// If we have CAD to JPY : CAD returns 0.76 USD.
let conversionDict : [String : Double] = [
    "USD" : 1.0,
    "JPY" : 0.0067,
    "CAD" : 0.7288,
    "Inches" : 1.0,
    "Meter" : 39.37,
    "Feet" : 12,
    "Kilometer" : 39370.1,
    "Farenheit" : 1.0,
    "Kelvin" : -457.87,
    "Celcius" : 33.8
]



struct ContentView: View {
    
    @State private var currentUnitSelection : UnitTypes = UnitTypes.currency
    @State private var fromUnit : SubUnitTypes = SubUnitTypes.cad
    @State private var toUnit : SubUnitTypes = SubUnitTypes.usd
    
    @State private var inputVal = ""
    @State private var outputVal : Double?
    
    @FocusState private var focused : Bool
    
    
    private var inputDouble : Double? {
        return Double(inputVal) ?? nil
    }
    
    // A computed property that will update the two unit pickers based on selection
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
                
                Section("From") {
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
                        .focused($focused)
                }
                
                Section("To") {
                    Picker("", selection: $toUnit) {
                        ForEach(selectedSubArr, id : \.self) { val in
                            Text(val.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    HStack{
                        Text("Output:")
                        Spacer()
                        Text("\(outputVal ?? 0.0 , specifier : "%.2f")")
                    }
                }
                
                HStack {
                    Button("Convert") {
                        outputVal = conversion(fromUnit,toUnit,inputDouble)
                    }
                    .buttonStyle(.borderless) // needed to add this otherwise both buttons were being pressed
                    
                    Spacer()
                    Button("Reset") {
                        fromUnit = SubUnitTypes.cad
                        toUnit = SubUnitTypes.usd
                        inputVal = ""
                    }
                    .foregroundColor(.red)
                    .buttonStyle(.borderless) // needed to add this otherwise both buttons were being pressed


                }
               
            }
            .navigationTitle("Conversion App")
            .toolbar {
                if focused {
                    Button("Done"){
                        focused = false
                    }
                }
            }
            
        }
        .padding()
        
    }
}

// By using enums, we can pass in the two types and then just use their raw values
// Raw values are then keys in the dictionary
func conversion (_ from : SubUnitTypes , _ to : SubUnitTypes, _ inputVal : Double?) -> Double? {
    
    
    guard let baseConversionVal = conversionDict[from.rawValue] else {
        return nil
    }
    if (inputVal == nil){
        return nil
    }
    
    
    var toBase = baseConversionVal * inputVal!
    switch to {
    case .jpy :
        return toBase * 148.35
    case .cad :
        return toBase * 1.372
    case .usd :
        return toBase * 1.0
    case .inches:
        return toBase * 1.0
    case .feet :
        return toBase * 12
    case .meter :
        return toBase * 39.37
    case .kilometer:
        return toBase * 39370.0787
    case .f:
        return toBase * 1.0
    case .c:
        return (toBase - 32) * (5/9)
    case .k:
        return (toBase + 459.67) * (5/9)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
