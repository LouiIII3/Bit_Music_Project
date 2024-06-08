//
//  UserProfileView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/27/23.
//

import SwiftUI

struct UserProfileView: View {
//    @State private var path = NavigationPath()
    var body: some View {
        NavigationLink(destination: SettingsLabelView(subject: "aaa", name: "bbb")) {
            Text("rmformformfo")
        }
//            NavigationLink {
//                SettingsLabelView(subject: "aaa", name: "bbb")
//            } label: {
//                Button(action: {
//                    print("눌렀는데")
//                }, label: {
//                    Text("Button")
//                        .foregroundStyle(.black)
//                })
//            }
        

    }
}

#Preview {
    UserProfileView()
}
