//
//  StartView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/3/23.
//

import SwiftUI



struct StartView : View {
    
    @Binding var activeGame: Bool
    @Binding var tables: Int
    @Binding var questions: Int
    
    let questionsArr = [5,10,15,20,25]
    
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
                Text("How many questions? \(questions)")
                    .font(.title3.bold())
                    .foregroundColor(.primary)
                Picker("", selection: $questions) {
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
        Button("Start Game"){
            activeGame = true
        }
        .buttonStyle(.styleOne)
    }
    
}

// Apple's reccommended styling : custom struct and then use extension

struct ButtonStyleOne : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.system(.title, weight: .bold))
            .foregroundColor(.white)
            .frame(width: .infinity, height: 48)
            .background(.orange)
            .cornerRadius(10)
    }
}

// This means only applied when self is a ButtonStyleOne. This
// is better since if other custom structs also are ButtonStyle, then
// they won't have this property
// Here it is basically saying
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
