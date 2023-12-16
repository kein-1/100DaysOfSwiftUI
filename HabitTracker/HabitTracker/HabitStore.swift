//
//  HabitDataModel.swift
//  HabitTracker
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI
import Observation



@Observable
class HabitStore  {
    
    
    // Will be updated based on user's click
    var currentDay = Date()
    
    // Represents a range of dates
    var rangeOfDays : [Date] {
        // Temp array to store the current dates
        var tempArr = [Date]()
        
        // Create an instance of the current calendar
        let calendar = Calendar.current
        
        let start = Date.now
        
        // creates basically a minus 21-days to plus 1 week date frame
        for val in -21..<8 {
            if let newDate = calendar.date(byAdding: .day, value: val, to: start) {
                tempArr.append(newDate)
            }
        }
        return tempArr
    }
    
    // Array of the user's added tasks
    var habitsPool : [String: [Habit]]
    
    // Array of Tasks based on the day
    var currentHabits : [Habit] {
        let dateToString = dateExtractor(date: currentDay, format: "d MMM yyyy")
        
        guard let habitsList = habitsPool[dateToString] else {
            return [Habit]()
        }
        print(habitsList)
        return habitsList
    }
    
    // Initializer
    init(){
        habitsPool = [String: [Habit]]()
    }
    
    
    
    
    // Function that uses a DateFormatter() to convert the Date to a string
    func dateExtractor(date : Date, format: String) -> String {
        let formatter = DateFormatter()
        
        //"d EEE" format gives bak the date number, and the day of the week
        formatter.dateFormat = format
        let string = formatter.string(from: date)
        return string
    }
    
    // Checks if the selected date is the same as our current date
    func dateVerifier(_ date : Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, inSameDayAs: currentDay)
    }
    
    func dateOffset() -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: 3, to: self.currentDay) ?? Date()
    }
    
    
    func addHabit(_ name : String, _ type : HabitType){
        let dateToString = dateExtractor(date: currentDay, format: "d MMM yyyy")
        
        
        let newHabit = Habit(name: name ,type: type, date: dateToString)
        
        // This means the list exists
        if var habitsList = habitsPool[dateToString] {
            habitsList.append(newHabit)
            habitsPool[dateToString] = habitsList
        } else {
            var newHabitList = [Habit]()
            newHabitList.append(newHabit)
            habitsPool[dateToString] = newHabitList
        }
    }
}
