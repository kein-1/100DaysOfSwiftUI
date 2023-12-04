//
//  NumberPadView.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/4/23.
//

import SwiftUI

// Grid for buttons
// big help : https://stackoverflow.com/questions/57010661/swiftui-number-pad-layout

struct NumberPadView : View {
    
    @Binding var userAnswer : String
    
    let columns : [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
                                
    
    let rows: [[String]] = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["↺", "0", "⌫"]
        ]
    
    var body : some View{
        VStack {
            Text("User answer : \(userAnswer)")
            // Lazy VGrid, means contents will be loaded as they appear on the screen
            LazyVGrid(columns: columns) {
                ForEach(rows, id : \.self){ row in
                    ForEach(row, id: \.self) { buttonTitle in
                        Button {
                           buttonHelper(buttonTitle)
                        } label: {
                            Text("\(buttonTitle)")
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    // Function called for each button 
    func buttonHelper(_ value : String){
        if let intVal = Int(value) {
            userAnswer += value
        } else {
            if value == "⌫" {
                userAnswer = String(userAnswer.dropLast())
                return
            }
            // must be reset then, so just clear
            userAnswer = ""
        }
    }
    
}




//struct NumberPadView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberPadView()
//    }
//}
