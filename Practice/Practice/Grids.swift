//
//  Grids.swift
//  Practice
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct Grids: View {
    
    let spacing : CGFloat = 10.0
    static let min : CGFloat = 50.0
    static let max : CGFloat = 100.0
    
// fixed : 3 columns all fixed size in width
//    let columns = [
//        GridItem(.fixed(50)),
//        GridItem(.fixed(50)),
//        GridItem(.fixed(50)),
//        ]
    
    // adaptive - fit as many as we can as long as they are the minimum width
    // that is defined
    let columns = [
        GridItem(.adaptive(minimum: min, maximum: max))
    ]
    
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: columns, spacing: spacing) {
                ForEach(0..<50){ item in
                    Text("Item \(item)")
                }
            }
        }
    }
}

#Preview {
    Grids()
}
