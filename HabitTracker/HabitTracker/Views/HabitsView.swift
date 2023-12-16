//
//  HabitsView.swift
//  HabitTracker
//
//  Created by Kein Li on 12/15/23.
//

import SwiftUI

struct HabitsView: View {
    
    // use the @Environment wrapper to access the store
    @Environment(HabitStore.self) private var habitStore
    
    var body: some View {
        VStack {
            Section {
                if habitStore.currentHabits.isEmpty {
                    Text("No habits for this day ! ")
                } else {
                    List {
                        
                    }
                }
            } header: {
                Text("Today's Habits")
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

//#Preview {
//    HabitsView()
//}
