//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kein Li on 11/23/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoringTitle = ""
    @State private var questionCount = 8
    
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.secondary)
                    
                    ForEach(0..<3){number in
                        Button {
                            flagTapped(countries, number)
                            print("\(number) was tapped")
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }

                    }
                }
                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.linearGradient(Gradient(colors: [.white,.accentColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                
                Spacer()
                Text("Score : \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            
        }
        .alert(scoringTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message : {
            Text("Your score is \(score). There are \(questionCount) questions remaining")
        }
        .alert("Game over!", isPresented: $gameOver) {
            Button("Reset your game", role: .destructive, action: resetGame)
        }
        
    }

    
    func flagTapped(_ countires : [String] ,_ number: Int){
        if number == correctAnswer {
            scoringTitle = "Correct"
            score+=1
        } else {
            scoringTitle = "Wrong! That’s the flag of \(countires[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCount-=1
        if questionCount == 0 {
            gameOver = true
        }
    }
    
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
        questionCount = 8
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
