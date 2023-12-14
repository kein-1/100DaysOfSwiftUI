//
//  Question.swift
//  Edutainment Math
//
//  Created by Kein Li on 12/5/23.
//

import Foundation

struct Question : Equatable, Hashable, Identifiable {
    var id = UUID()
    var question : String
    var answer : Int  = 0 // default
    var correct : Bool = false 
}

