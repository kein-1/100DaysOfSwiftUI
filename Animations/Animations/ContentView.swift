//
//  ContentView.swift
//  Animations
//
//  Created by Kein Li on 12/2/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dragAmount = CGSize.zero
    @State private var animationAmount = 1.0
    @State private var isShowingRed = false
    @State private var isShowingBlue = false

    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Button("Tap Me 1") {
                    //By wrapping in withAnimation, any changes associated with isShowingRed will have animation
                    isShowingRed.toggle()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.automatic)
                
                Button("Tap Me 2") {
                    //By wrapping in withAnimation, any changes associated with isShowingRed will have animation
                    isShowingBlue.toggle()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.automatic)

                .foregroundColor(isShowingRed ? .red : .white)
                
                Spacer()
                RoundedRectangle(cornerRadius: 25)
                    .fill(isShowingRed ? .red : .blue)
                    .frame(width: 200, height: 200)
                
                // This will also have some animation
                RoundedRectangle(cornerRadius: 25)
                    .fill(isShowingBlue ? .blue : .red)
                    .frame(width: 200, height: 200)
                    .offset(y: isShowingBlue ? 25 : 50)
                Spacer()
            }
            // value here is anything that relies ONLY
            // on isShowingBlue will apply this animation
            // Notice the change in rect2 with some fading since it depends on isShowingBlue
            // This lets us apply animations to only certain views
            // so now the .easeInOut will apply this animation to show any changes. now .fill and .offset
            // will have a smoother transition
            .animation(.easeInOut(duration: 2), value: isShowingBlue)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
