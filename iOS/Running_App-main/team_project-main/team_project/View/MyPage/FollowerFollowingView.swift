//
//  FollowerView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct FollowerFollowingView: View {
    @State var selectedTab: decide
    var body: some View {
        NavigationView(content: {
            VStack {
                Picker(selection: $selectedTab) {
                    ForEach(decide.allCases, id: \.self, content: { selected in
                        Text(selected.rawValue)
                    })
                } label: {}
                .pickerStyle(.segmented)
                .padding()
                
                
                Spacer()
            }
            
        })
    }
}

enum decide: String, CaseIterable {
    case follower = "팔로워"
    case following = "팔로잉"
    
}

#Preview {
    FollowerFollowingView(selectedTab: .follower)
}
