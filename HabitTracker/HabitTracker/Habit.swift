//
//  Habit.swift
//  HabitTracker
//
//  Created by Kein Li on 12/15/23.
//

import Foundation


struct Habit : Identifiable {
    let id = UUID()
    let name : String
    let description : String
    let date = Date()
    let isCompleted = false
}
