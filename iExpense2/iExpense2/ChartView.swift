//
//  ChartView.swift
//  iExpense2
//
//  Created by Kein Li on 12/12/23.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    var expenses : [String:Double]
    
    var body: some View {
        Chart {
            // For each does not work with dict. so
            // make array with keys then use the dict itself
            ForEach(Array(expenses.keys), id: \.self){ name in
                SectorMark(
                    angle: .value("expense", expenses[name] ?? 0.0),
                    innerRadius: .ratio(0.5),
                    outerRadius: .fixed(150),
                    angularInset: 3
                )
                .foregroundStyle(by: .value("type", name))
                .cornerRadius(5)
                .annotation(position: .overlay, alignment: .centerLastTextBaseline) {
                    Text(expenses[name] ?? 0.0, format: .currency(code: "USD"))
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
            }
            
        }
        .frame(width: .infinity, height: 250)
        .padding()
    }
}

//#Preview {
//    
//    // test data
//    let expenses : [String : Double] = [
//        "Food" : 50.0,
//        "Household" : 250.0,
//        "Education" : 120.0,
//        "Travel" : 50.0,
//        "Misc" : 510.0,
//        
//    ]
//    
//    return ChartView(expenses: expenses)
//}
