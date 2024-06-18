//
//  UserInfoViewContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI

struct UserInfoViewContainer: View {
    var body: some View {
        HStack {
            Text("현재 티어: 브론즈")
            Text("앞으로 0Kg 남았습니다")
            Spacer()
        }.padding()
    }
}

#Preview {
    UserInfoViewContainer()
}
