//
//  LandingView.swift
//  HabitTracker
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct LandingView: View {
    
    @State private var habitModel = HabitDataModel()
    
    
    var body: some View {
        NavigationStack {
            
            DateView(habitModel: $habitModel)
        }
        .padding()
        
    }
    
    
    
    
    
    
    
    
    
    
}

#Preview {
    LandingView()
}
