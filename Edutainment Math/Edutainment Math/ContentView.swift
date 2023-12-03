//
//  ContentView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/3/23.
//

import SwiftUI

struct ContentView: View {
    
    
    static let imagesArr = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "goat", "hippo", "monkey", "owl", "panda", "snake"]
    
    
    @State private var activeGame = false
    @State private var tables = 2
    @State private var questions = 5
    @State private var currImage = imagesArr.randomElement()!
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(currImage)
                    .frame(width: 150, height: 150)
                
                Spacer()
                if activeGame {
                    
                    VStack {
                        Text("put the active game view here")
                        Text("\(tables) + \(questions)")
                    }
                } else {
                    StartView(activeGame: $activeGame, tables: $tables, questions: $questions)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .navigationTitle("Multiply!")
            .background(LinearGradient(
                gradient: Gradient(colors: [.blue, .green]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
