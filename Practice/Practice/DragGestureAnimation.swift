//
//  DragGestureAnimation.swift
//  Practice
//
//  Created by Kein Li on 12/7/23.
//

import SwiftUI

struct DragGestureAnimation: View {
    
    
    var body: some View {
        CardView()
    }
}

struct CardView : View {
    @State private var dragAmount = CGSize.zero
    
    var drag : some Gesture {
        DragGesture()
        
            // While it is being dragged. closure receives a DragGesture.value
        // whihc contains info about the change. DragGesture value is provided
        // by SwiftUI when DragGesture() is made
            .onChanged { movement in
                dragAmount = movement.translation
            }
        
            // When drag animation ends
            .onEnded { _ in
                withAnimation(.spring()) {
                    dragAmount = CGSize.zero
                }
            }
    }
    
    var body : some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.orange)
            .frame(width: 200, height: 200)
            .offset(dragAmount)
            .gesture(drag)
    }
}

struct DragGestureAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureAnimation()
    }
}
