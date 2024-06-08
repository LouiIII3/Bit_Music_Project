//
//  SettingToggleView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct SettingToggleView: View {
    @State private var isPressed = false
    var name: String
    var body: some View {
        VStack {
            Toggle(isOn: $isPressed, label: {
                Text(name)
            })
        }
    }
}

#Preview {
    SettingToggleView(name: "알람 푸시")
}
