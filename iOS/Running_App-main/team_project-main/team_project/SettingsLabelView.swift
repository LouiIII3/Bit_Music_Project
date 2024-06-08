//
//  SettingsLabelView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct SettingsLabelView: View {
    var subject: String
    var name: String
    
    var body: some View {
        VStack {
            Divider().padding(.vertical, 4)
            HStack {
                Text(subject).foregroundStyle(.gray)
                Spacer()
                Text(name)
            }
        }
    }
}

#Preview {
    SettingsLabelView(subject: "유저이름", name: "taewon")
        .previewLayout(.sizeThatFits)
}
