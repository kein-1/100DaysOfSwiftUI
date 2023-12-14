//
//  ContentView.swift
//  iExpense
//
//  Created by Kein Li on 12/10/23.
//

import SwiftUI
//import Observation // this is newest in iOS17. Replaces using @Observable Object

// If changed to class, @State will not reload view to notice the change. Why ?
// Struct changes -> new one gets made. Classes can change but no new one made. So swfit does not know with
// at @State

struct User {
    var firstName = ""
    var lastName = ""
}

struct ContentView: View {
    
    @State private var user = User()
    @State private var showSheet = false
    
    var body: some View {
        Form {
            Text("Your name is \(user.firstName) \(user.lastName)")
            Section {
                TextField("First Name :", text: $user.firstName)
                TextField("Last Name :", text: $user.lastName)
            }
            
            Section{
                Button("Show sheet"){
                    showSheet.toggle()
                }
                // Modifier that slides in a view like a "sheet"
                // The 2nd argument is the view to show
                
                .sheet(isPresented: $showSheet) {
                    secondSheet()
                }
            }
                
        }
        .padding()
    }
}

struct secondSheet : View {
    
    // Use environemnt : this is a property wrapper that stores the context of the view's
    // environment. So this could be something like the system's color scheme (light or dark mode) etc and then we can program the view to do something based on the color
    // Seems like environment is something like system setting
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(colorScheme == .light ? "I am light" : "I am dark")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
