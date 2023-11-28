//
//  ContentView.swift
//  BetterRest
//
//  Created by Kein Li on 11/27/23.
//
import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("When do you want to wake up ? ")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: [.hourAndMinute]).labelsHidden()
                
                Stepper("Enter hours slept : \(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                
                Stepper("Enter coffee drank : \(coffeeAmount)", value: $coffeeAmount, in: 1...10)
                
                Text(wakeUp.formatted())
            }
            .padding()
            .navigationTitle("Better Rest")
            .toolbar {
                ToolbarItem {
                    Button("Calculate bed time"){
                        calculateBedTime()
                    }
                }
            }
            .alert(alertTitle, isPresented: $showAlert) {
                Button("Dismiss") { }
            } message: {
                Text(alertMessage)
            }

        }
    }
    
    // use do/catch/ try since the ML model can throw an error
    // try is used inside a do block indicating this function can throw an error
    func calculateBedTime() {
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
            
            alertTitle = "Your ideal bed time is :"
            alertMessage = sleepTime.formatted(date: .omitted, time: .complete)

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showAlert = true
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
