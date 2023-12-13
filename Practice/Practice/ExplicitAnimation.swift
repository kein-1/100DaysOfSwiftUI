//
//  ExplicitAnimation.swift
//  Practice
//
//  Created by Kein Li on 12/7/23.
//

import SwiftUI

struct ExplicitAnimation: View {
    @State private var expanded = false
    @State private var expanded2 = false

    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.red)
                .frame(width: expanded ? 250 : 100,height: expanded ? 250 : 100)
            
            RoundedRectangle(cornerRadius: 25)
                .fill(.blue)
                .frame(width: expanded2 ? 250 : 100,height: expanded2 ? 250 : 100)
            
            Text("hello")
            Button("Click me"){
                withAnimation {
                    expanded.toggle() // notice only red rect will have animation. this is explicit so more control
                }
                expanded2.toggle() // this will cause blue rect to have no animation since
                // it is not wrapped in withAnimation
            }
        }
//        .animation(.spring(), value: expanded) // can add this here to affect both
        .padding()
    }
}

struct ExplicitAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimation()
    }
}
