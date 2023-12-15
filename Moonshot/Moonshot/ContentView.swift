//
//  ContentView.swift
//  Moonshot
//
//  Created by Kein Li on 12/13/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("press"){
            doSomething()
        }
        .background(<#T##style: ShapeStyle##ShapeStyle#>, in: <#T##Shape#>)
    }
    
    func doSomething() {
        Bundle.main.decode("astronauts.json")
    }
}

#Preview {
    ContentView()
}
