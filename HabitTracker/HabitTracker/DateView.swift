//
//  DateView.swift
//  HabitTracker
//
//  Created by Kein Li on 12/14/23.
//

import SwiftUI

struct DateView: View {
    
    @Binding var habitModel : HabitDataModel
    
    var body: some View {
        Section {
            ScrollView(.horizontal ) {
                HStack(alignment: .center) {
                    Button("", systemImage: "arrow.backward") {
                        habitModel.subtractWeek()
                    }
                    ForEach(habitModel.currWeek, id: \.self){ date in
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(habitModel.dateVerifier(date) ? .blue : .gray, lineWidth: 3)
                            .fill(.clear)
                            .overlay {
                                VStack {
                                    Text(habitModel.dateExtractor(date: date, format: "dd"))
                                        .font(.caption)

                                    Text(habitModel.dateExtractor(date: date, format: "EEE"))
                                        .font(.caption2)
                                }
                            }
                            .frame(width: 45, height: 60, alignment: .center)
                            .onTapGesture {
                                habitModel.currentDay = date
                                print(habitModel.currentDay)
                            }
                        
                    }
                    Button("", systemImage: "arrow.forward") {
                        habitModel.addWeek()
                    }
                }
            }
            
            
            
        } header: {
            Text("i am header")
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    let model = HabitDataModel()
    return DateView(habitModel: .constant(model))
}
