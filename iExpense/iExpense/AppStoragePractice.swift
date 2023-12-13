//
//  AppStorage.swift
//  iExpense
//
//  Created by Kein Li on 12/10/23.
//

import SwiftUI

// learn about UserDefault.standard and @AppStorage for persistant data
struct AppStoragePractice: View {
    
    // Specify the key and type. Key is what the name is saved under so SwiftUI
    // can retrieve that data using this key later
    @AppStorage("name") var name = ""
    
    // the above code is equivalent to : UserDefault.standard.set(val,key for retrieval)
    // then doing UserDefault.standard.<type>(key) to retrieve
    
    var body: some View {
        
        VStack {
            
            Text("My name is : " + name)

            Button("Save"){
                let str = "kein121233"
                name = str
            }
        }
        
    }
}

struct AppStoragePractice_Previews: PreviewProvider {
    static var previews: some View {
        AppStoragePractice()
    }
}
