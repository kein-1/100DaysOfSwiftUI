//
//  StartView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/3/23.
//

import SwiftUI



struct StartView : View {
    
    @Binding var activeGame: Bool
    @Binding var questionBank : [Question]
    
    @State private var tables = 2
    @State private var questionCount = 5
    
    let questionsArr = [5,10,15,20,25]
    
    let numbersArrayOne = Array(0..<10).shuffled()

    var body: some View{
        VStack {
            Spacer()
            
            VStack(alignment: .center) {
                
                Text("Practice which tables? \(tables)")
                    .font(.title3.bold())
                
                // Use labelsHidden to hide the text center
                Stepper("", value: $tables, in: 2...12)
                    .labelsHidden()
                
            }
            
            Spacer()
            
            VStack {
                Text("How many questions? \(questionCount)")
                    .font(.title3.bold())
                Picker("", selection: $questionCount) {
                    ForEach(questionsArr, id: \.self){ numb in
                        Text("\(numb)").tag(numb)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Spacer()
            
            ButtonView
            
        }
        .padding()
        
    }
    
    var ButtonView : some View {
            
        Button {
            updateSettings()
            activeGame = true
        } label: {
            Text("Start Game!")
                .padding()
        }
        .buttonStyle(.styleOne)

        
       
    }
    
    func updateSettings(){
        let numbersArrayTwo = Array(0..<tables).shuffled()
        
        while questionBank.count < questionCount {
            
            let randomOne = numbersArrayOne.randomElement()!
            let randomTwo = numbersArrayTwo.randomElement()!
            let answer = randomOne * randomTwo
            let string = "\(randomOne) x \(randomTwo) = "
            let question = Question(question: string, answer: answer)
            if !questionBank.contains(question){
                questionBank.append(question)
            }
        }
    }
    
}

// Apple's reccommended styling : custom struct and then use extension
// ButtonStyleOne conforms to ButtonStyle, meaning it must implement makeBody
struct ButtonStyleOne : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label // must add configuration.label, indicating it is this one using it
            .padding()
            .font(.system(.title, weight: .bold))
            .foregroundColor(.white)
            .frame(width: .infinity, height: 48)
            .background(.orange)
            .cornerRadius(14)
    }
}

// This means only applied when self is a ButtonStyleOne. This
// is better since if other custom structs also are ButtonStyle, then
// they won't have this property
// Here it is basically saying when the type is ButtonStyleOne, then it will have this property
extension ButtonStyle where Self == ButtonStyleOne {
    static var styleOne : ButtonStyleOne {
        ButtonStyleOne()
    }
}



//struct StartView_Previews: PreviewProvider {
//    
//    // use .constant to pass in dummy binding values for testing
//    static var previews: some View {
//        StartView(activeGame: .constant(false), tables: .constant(2), questions: .constant(2))
//    }
//}
