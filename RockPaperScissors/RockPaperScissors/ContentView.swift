//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kein Li on 11/24/23.
//

import SwiftUI

struct ContentView: View {
    
    let options = [("Rock","r.circle"), ("Paper","newspaper"), ("Scissors", "scissors")]
    let sysNames = ["r.circle", "newspaper", "scissors"]
    
    
    
    @State private var playerChoice = ("","")
    
    @State private var computerChoice = ("", "")
    @State private var gameStatus = false
    @State private var chosen = false
    @State private var winner = ""
    @State private var playerScore = 0
    @State private var computerScore = 0
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if gameStatus {
                    GameBoard
                }
                
                Spacer()
                HStack {
                    ForEach(0..<3){ numb in
                        Spacer()
                        Button {
                            playerChoice = options[numb]
                        }
                        label: {
                            VStack{
                                Image(systemName: options[numb].1)
                                    .font(.largeTitle)
                                Text(options[numb].0)
                                    .foregroundColor(.primary)
                            }
                        }
                        .buttonStyle(MyButtonStyle())
                        Spacer()
                    }
                }
                .padding()
                
                PlayButton
            }
            // Seems to be the only way to center the navigation title :
            // use the toolbar modifier and make a ToolbarItem in it
            .toolbar {
                
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Rock Paper Scissors")
                        .font(.title.bold())
                        .foregroundColor(.primary)
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        gameStatus = false
                        winner = ""
                        playerChoice = ("","")
                        computerChoice = ("","")
                    } label: {
                        VStack {
                            Image(systemName: "multiply")
                            Text("New game")
                        }
                        .foregroundColor(.red)
                    }

                }
                
            }
            .padding()
        }
    }
        
    // Computed property to define a view
    var PlayButton : some View {
        Button {
            computerChoice = options[Int.random(in: 0..<3)]
            play(playerChoice.0, computerChoice.0)
        } label: {
            Text("Play")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
    
    
    var GameBoard : some View {
        VStack{
            HStack {
                Text("You : \(playerScore)").textModifier()
                Spacer()
                Text("Computer : \(computerScore)").textModifier()
            }
            
            VStack {
                Text("You chose \(playerChoice.0)")
                    .padding()
                Image(systemName: playerChoice.1 )
                    .font(.system(size: 60))
            }
            
            Spacer()
            
            VStack {
                Text("Computer chose \(computerChoice.0)").padding()
                Image(systemName: computerChoice.1)
                    .font(.system(size: 60))
            }
            Spacer()
            
            if winner == "Tie" {
                Text("There is a tie!")
            } else {
                Text("The winner is \(winner) !")
                    .font(.title3.bold())
                    .foregroundColor(.blue)
            }
            Spacer()
        }
    }
    
    
    func play(_ playerChoice : String, _ computerChoice : String){
        gameStatus = true
        chosen = false
        
        switch playerChoice {
        case "Rock":
            if computerChoice == "Rock" { winner = "Tie"}
            else if computerChoice == "Scissor" {
                winner = "Player"
                playerScore += 1
            } else {
                winner = "Computer"
                computerScore +=  1
            }
        case "Paper":
            if computerChoice == "Paper" { winner = "Tie"}
            else if computerChoice == "Rock" {
                winner = "Player"
                playerScore += 1
            } else {
                winner = "Computer"
                computerScore += 1
            }
        case "Scissors":
            if computerChoice == "Scissors" { winner = "Tie"}
            else if computerChoice == "Paper" {
                winner = "Player"
                playerScore+=1
            } else {
                winner = "Computer"
                computerScore+=1
            }
        default:
            return
        }
    }
}

// Make custom button style that styles the button and allows to know when it is picked
struct MyButtonStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.blue)
            .background(configuration.isPressed ? .mint : .clear)
            .cornerRadius(5.0)
    }
}

// Custom text modifier for practice : apple recommends combining view modifier + extensions
// So create the struct, then use extension with .modifier and pass in this val
// struct must have a body and content. content refers to the actual view using it. So here its Text
// Using Extension with this is cleanr so we don't need to apply .modifier to the view itself when calling it. We instead
// apply it as an extension :

// So instead of doing Text("hi).modifier(custom struct), we just do Text("hi).function name . This is how we access the stuff in extensions
struct ScoreTextModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.primary)
            .padding()
    }
}


extension View {
    func textModifier() -> some View {
        modifier(ScoreTextModifier())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
