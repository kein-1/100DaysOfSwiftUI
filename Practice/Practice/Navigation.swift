//
//  Navigation.swift
//  Practice
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI


struct Student : Hashable, Identifiable {
    let id = UUID()
    let name : String
    let age : Int
}

struct Navigation: View {
    
    let studentArr : [Student] = [Student(name: "bob", age: 10), Student(name: "Ken", age: 123), Student(name: "Jess", age: 20)]
    
    // can specify our own path : navigation stack will track views
    // based on the path array we bind it to. this is often used
    // in programmatic navigation : i.e if program is processing some data
    // and we want to navigate to a new screen once the data is done
    // rather than waiting for the user to press it 
    
    @State private var path : [Student] = [Student]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(studentArr) { student in
                NavigationLink("Select \(student.name)", value: student)
                // navigation link w/ value :
                // works with navigationDestination. Basically saying
                // when we click this value, produce this view
            }
            .navigationDestination(for: Student.self) { student in
                VStack {
                    Text(student.name)
                    Text("\(student.age)")
                }
            }
            
            Button("press me"){
                path.append(studentArr[0])
                path.append(studentArr[1])
                print(path)
            }
            
        }
    }
    
}

struct DetailView: View {
    
    var number : Int
    
    var body: some View {
        Text("Detail View \(number)")
    }
    
    init(number : Int){
        self.number = number
        print("Creating detail view \(number)")
    }
}



#Preview {
    Navigation()
}
