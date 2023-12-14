//
//  Lists.swift
//  Animations
//
//  Created by Kein Li on 12/2/23.
//

import SwiftUI

struct Lists: View {
    
    
    @State private var arr = ["apple", "fruit", "eggs", "rice"]
    
    var body: some View {
        NavigationStack{
            List{
                Section("Food") {
                    ForEach(arr, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete { indexSet in
                        deleteItem(at : indexSet)
                    }
                }
            }
            .navigationTitle("Groceries")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }
    
    func deleteItem(at indexSet : IndexSet){
        print(indexSet)
        arr.remove(atOffsets: indexSet)
    }
}

struct Lists_Previews: PreviewProvider {
    static var previews: some View {
        Lists()
    }
}
