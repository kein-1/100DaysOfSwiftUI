//
//  ContentView.swift
//  ViewModifiers
//
//  Created by Kein Li on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Hello, world!") {
                // do nothing
            }
            .frame(width: 200, height: 200)
            .background(.red)
            
            spells
        }
        
        .padding()
    }
    
    @ViewBuilder
    var spells : some View {
        Text("hi")
        Text("hi2").titleModifier()
    }
}



struct SomeTitle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.primary)
    }
}

extension View {
    func titleModifier () -> some View {
        modifier(SomeTitle())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
