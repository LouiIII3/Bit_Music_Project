//
//  RecordViewContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI
import SwiftData

struct RecordViewContainer: View {
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            VStack {
                DatePickerView(date: $date)
                
                RecordRoutineView(date: date)
            }
        }
    }
}

#Preview {
    RecordViewContainer()
}
