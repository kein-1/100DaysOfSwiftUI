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
    
    @State private var userScore = 0
    
    @State private var answeredQuestions = [Question]()
    
    @State var currentQuestion : Question?
    
    @State private var userAnswer = ""
    
    var questionBank : [Question]
    
    var body: some View {
        
        VStack {
            Text("Score : \(userScore)")
            
            PreviousQuestionsView
            NumberPadView(userAnswer: $userAnswer)
            
            Spacer()
            
            Button("Submit!"){
                check()
                print(questionBank)
                print(answeredQuestions)
            }
            .buttonStyle(.styleOne)
            
        }
    }
    
    // Get new quesiton. run loop until it is a unique element.
    // use this with the "submit" button, so when user
    // presses "submit", the score is calculated and
    // a new question is generated. likely need another function calling this
    func newQuestion(){
        
        var random = questionBank.randomElement()!
        while (answeredQuestions.contains(random)){
            random = questionBank.randomElement()!
        }
        
        if let unwrapped = currentQuestion {
            answeredQuestions.append(unwrapped)
            currentQuestion = random
            return;
        }
    }
    
    func check(){
        if currentQuestion?.answer == Int(userAnswer){
            userScore += 1
        }
        userAnswer = ""
        newQuestion()
    }
    
    
    // View for displaying the previous questions
    var PreviousQuestionsView : some View {
        VStack {
            Text(currentQuestion?.question ?? "")
            ForEach(answeredQuestions.suffix(3), id : \.self){ question in
                Text(question.question)
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
