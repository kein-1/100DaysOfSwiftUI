//
//  LandingView.swift
//  HabitTracker
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct LandingView: View {
    
    @State private var selected = 0
    
    var body: some View {
        // TabViews are designed to sit at the top of the view hiearchy
        // add .tabItem for tabs
        // Apple also desgiend TabView and NavigationStack to not work together..
        // So instead In my homeview i Put the navigation stack there
        TabView(selection: $selected) {
            
            // Landing page
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            // Personal tab view
            ContentView()
                .tabItem {
                    Label("Personal", systemImage: "person")
                }
                .tag(1)
            
            AddHabitsView(selected: $selected)
                .tabItem {
                    Label("Add a Habit", systemImage: "plus")
                }
                .tag(2)
        }
    }
}

#Preview {
    // need to add this otherwise view crashes
    let store = HabitStore()
    return LandingView()
        .environment(store)
}
