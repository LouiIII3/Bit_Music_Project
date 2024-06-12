//
//  DateView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI

struct DatePickerView: View {
    @Binding var date: Date

    var body: some View {
        DatePicker(
            "",
             selection: $date,
             displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
    }
}

#Preview {
    DatePickerView(date: .constant(Date()))
}
