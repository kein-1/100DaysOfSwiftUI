//
//  ContentView.swift
//  BetterRest
//
//  Created by Kein Li on 11/27/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    private var bedTime : String {
        calculateBedTime()
    }
    
    
    @State private var showAlert = false
    
    static var defaultWakeTime : Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: [.hourAndMinute]).labelsHidden()
                } header: {
                    Text("What time do you wake up?")
                        .bold()
                }

                Section ("Enter Hours of Sleep"){
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Label("\(sleepAmount.formatted())", systemImage: "bed.double")
                    }
                }
                
                Section ("Enter Coffe Drank"){
                    Picker("\(coffeeAmount.formatted())", selection: $coffeeAmount) {
                        ForEach(1..<11){ number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Your ideal Bedtime is") {
                    Text(bedTime)
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .navigationTitle("Better Rest")
        }
    }
    
    // use do/catch/ try since the ML model can throw an error
    // try is used inside a do block indicating this function can throw an error
    func calculateBedTime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // What this does is extract the date components from some instance of Date.
            // Date itself does not have these properties
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hourToSeconds = (components.hour ?? 0) * 3600
            let minuteToSeconds = (components.second ?? 0) * 60
            
            
            let prediction = try model.prediction(wake: Double(hourToSeconds + minuteToSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            
            // .formatted for dates use DateFormatter() under the hood. sleepTime is a Date() object
            // so with this, we modify to use the local time zone of the user
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.timeStyle = .medium
            
            // .formatted for dates use DateFormatter() under the hood
            return dateFormatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            return("Sorry, there was a problem calculating your bedtime.")
        }
    }
}

struct fakeView : View {
    @Binding var value : Double
    var body : some View{
        Text("I am the value \(value)")
        
        Button("I am a value") {
            value += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
