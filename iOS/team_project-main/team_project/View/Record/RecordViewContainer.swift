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
    @Environment(NavigationObject.self) private var path
    
    var body: some View {
        VStack {
            DatePickerView(date: $date)
            
            RecordRoutineView(date: date)
        }
        .onAppear {
            path.tab = false
        }
    }
}

#Preview {
    RecordViewContainer()
        .environmentObject(NavigationObject())
    
}
