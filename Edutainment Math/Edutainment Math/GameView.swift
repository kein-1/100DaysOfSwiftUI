//
//  GameView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/3/23.
//

import SwiftUI

struct GameView: View {
    
    @Binding var activeGame : Bool
    @Binding var currImageIndex : Int
    @Binding var questionBank : [Question]
    
    @State private var userScore = 0
    @State private var answeredQuestions : [Question] = [Question(question:" "), Question(question:" ")]
    @State var currentQuestion : Question?
    @State private var userAnswer = ""
    
    @State private var showAlert = false
    
    
    var body: some View {
        
        VStack {
            Text("Score : \(userScore)")
                .font(.headline.bold())
            
            HStack {
                Text(currentQuestion?.question ?? "")
                    
                Text(userAnswer)
            }
                    .font(.title2.bold())
            
            PreviousQuestionsView
            Divider()
            NumberPadView(userAnswer: $userAnswer)
            
            Spacer()
            
            Button("Submit!"){
                print(questionBank.count)
                check()
            }
            .buttonStyle(.styleOne)
            .alert("Game over ! Your score is \(userScore)", isPresented: $showAlert) {
                Button("New Game") {
                    activeGame = false
                }
            }
            
            Spacer()
        }
        .padding()
    }
    
    // Get new quesiton. run loop until it is a unique element.
    // use this with the "submit" button, so when user
    // presses "submit", the score is calculated and
    // a new question is generated. likely need another function calling this
    func newQuestion() -> Bool {
        
        
        // Number of questions answered. Originally was using questionBank size with removeLast() but gave me errors
        if (answeredQuestions.count - 2 == questionBank.count) {
            return false
        }
        
        let random = questionBank.randomElement()!
        
        if let unwrapped = currentQuestion {
            let correct = unwrapped.answer == Int(userAnswer) ? true : false
            let newStr = unwrapped.question.trimmingCharacters(in: CharacterSet(charactersIn: "?")) + (correct ? String(unwrapped.answer) : userAnswer)
            
            
            answeredQuestions.append(Question(question: newStr, answer: unwrapped.answer, correct: correct))
            
            currentQuestion = random
        }
        return true;
    }
    
    // Runs the check, then generates a new question and resets the user's answer
    func check(){
        if currentQuestion?.answer == Int(userAnswer){
            userScore += 1
        }
        
        // game is over, so show the alert
        if (newQuestion() == false){
            print("\(questionBank.count) + in ")
            showAlert = true
        }
        userAnswer = ""
    }
    
    
    // View for displaying the previous questions
    var PreviousQuestionsView : some View {
        VStack {
            
            ForEach(answeredQuestions.suffix(2), id : \.id){ question in
                Text(question.question)
                    .font(.title3.bold())
                    .foregroundColor(question.correct ? .green : .red)
                    .opacity(question.correct ? 0.75 : 0.25)
            }
        }
        
    }
    
    
    
}



//struct GameView_Previews: PreviewProvider {
//
//    let testData = [Question(question: <#T##String#>, answer: <#T##Int#>)]
//
//    static var previews: some View {
//        GameView(activeGame: .constant(true), currImageIndex: .constant(1), questionBank: <#T##[Question]#>)
//    }
//}
