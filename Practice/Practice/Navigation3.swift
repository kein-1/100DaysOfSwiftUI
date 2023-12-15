//
//  Navigation3.swift
//  Practice
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct Navigation3: View {
    @State private var path = NavigationPath()
    var body: some View {
        
        NavigationStack(path: $path) {
            List(0..<5) { numb in
                NavigationLink("select \(numb)", value: numb)
            }
            .navigationDestination(for: Int.self) { number in
                testView(number : number, path: $path)
            }
            .navigationTitle("title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("tap me") {}
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button("tap me2") {}
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("tap m3e") {}
                }
            }
            .navigationBarBackButtonHidden()
            
        }
    }
}

struct testView : View {
    
    
    var number : Int
    @Binding var path : NavigationPath
    
    var body : some View {
        
        VStack {
            Text("I am in view \(number)")
            Button("go home"){
                path = NavigationPath()
            }
        }
    }
}


#Preview {
    Navigation3()
}
