//
//  ContentView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/3/23.
//

import SwiftUI


// Cover : add a timer as well for how long spent on each question
// add a score for number of correct
// consider using a numb pad of 10 digits : 0 - 9 (use grid)
// then submit button (enter) which will then check whether
// it was correct or not, and also generate a new question


struct ContentView: View {
    
    
    static let imagesArr = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "goat", "hippo", "monkey", "owl", "panda", "snake"]
    
    
    @State private var activeGame = false
    @State private var tables = 2
    @State private var questionCount = 5
    @State private var currImageIndex = Int.random(in: 0...imagesArr.count - 1)
    
    @State private var userScore = 0
    @State private var questionBank = [Question]()
    
    
    
    var body: some View {
        NavigationStack {
            VStack{
                Image(ContentView.imagesArr[currImageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: activeGame ? 115 : 150 , height: activeGame ? 115 : 150)
                    .padding()
                
                Spacer()
                if activeGame {
                    GameView(activeGame: $activeGame, currImageIndex: $currImageIndex, questionBank : $questionBank, currentQuestion: questionBank[0])
                        .transition(.scale)
                        .animation(.easeInOut, value: activeGame)
                } else {
                    StartView(activeGame: $activeGame,  questionBank: $questionBank)
                        .transition(.scale)
                        .animation(.easeInOut, value: activeGame)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(20)
            .navigationTitle("Multiply!")
            .background(LinearGradient(
                gradient: Gradient(colors: [.white, .cyan ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ))
            .foregroundColor(.white)
            .toolbar {
                if activeGame {
                    Button("Reset game"){
                        withAnimation {
                            activeGame = false
                        }
                    }
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
