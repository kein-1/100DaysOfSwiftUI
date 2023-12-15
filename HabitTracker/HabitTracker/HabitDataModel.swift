//
//  HabitDataModel.swift
//  HabitTracker
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI
import Observation



@Observable
class HabitDataModel  {
    
    
    
    
    // Will be updated based on user's click
    var currentDay = Date()
    
    // Represents the current week
    var currWeek : [Date] {
        
        // Temp array to store the current dates
        var tempArr = [Date]()
        
        // Create an instance of calendar, then get a date interval based on the current
        // calendar. We specify the current week of the month , based on the current Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: currentDay)
        
        // the above returns a DateInterval? optional, so we need to unwrap
        // with optional unwrap. week? is DateInterval? so we unwrap with "." chaining
        let start = week?.start ?? Date()
        
        // creates 8 dates, by adding in .day units, adding a val, to some start date
        for val in 1..<8 {
            if let newDate = calendar.date(byAdding: .day, value: val, to: start) {
                tempArr.append(newDate)
            }
        }
        return tempArr
    }
    
    
    var 
    
    
    
    
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
    
    func subtractWeek() {
        let calendar = Calendar.current
        currentDay = calendar.date(byAdding: .day, value: -7, to: currentDay) ?? Date()
    }
    
    func addWeek() {
        let calendar = Calendar.current
        currentDay = calendar.date(byAdding: .day, value: 7, to: currentDay) ?? Date()
    }
}
