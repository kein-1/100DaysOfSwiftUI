//
//  Navigation2.swift
//  Practice
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct Navigation2: View {
    
    // deal with programatic navigation which consists of different
    // types using NavigationPath
    // originally we had an array of a single data type
    
    @State private var path = NavigationPath()
    var body: some View {
        
        NavigationStack(path: $path) {
            List(0..<5) { numb in
                NavigationLink("select \(numb)", value: numb)
            }
            // So now, each time we nagivate to this value that is a string,
            // we have this view
            // thus nagivation destination is like the view we want to show
            // when the value we are monitoring is selected
            .navigationDestination(for: String.self) { string in
                VStack {
                    Text("we are in \(string)")
                    Text("we are in \(string)")
                    Text("we are in \(string)")
                }
            }
            
            .navigationDestination(for: Int.self) { numb in
                VStack {
                    Text("we are \(numb)")
                    Text("we are \(numb)")
                    Text("we are \(numb)")
                }
            }
            
            .toolbar {
                ToolbarItem {
                    Button("press me1") {
                        path.append("i am a string")
                    }
                }
                
                ToolbarItem {
                    Button("press me2") {
                        path.append(123)
                    }
                }
            }
        }
    }
}


#Preview {
    Navigation2()
}
