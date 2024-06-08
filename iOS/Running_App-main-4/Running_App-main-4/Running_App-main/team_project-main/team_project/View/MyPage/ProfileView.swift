//
//  ProfileView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var path: [String] = []
    @State private var selection: [String] = [ "UserProfileView", "UserPostedView", "FollowerView", "FollowingView", "SettingView"]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack(spacing: 40) {
                    NavigationLink(value: selection[0]) {
                        VStack {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 45, height: 45)
                            Text("happyytw")
                        }.onTapGesture(perform: {
                            print("프로필")
                            path.append("UserProfileView")
                        })
                    }
                    NavigationLink(value: selection[1]) {
                        VStack {
                            Text("0")
                            Text("게시물")
                        }.onTapGesture(perform: {
                            print("게시물")
                            path.append("UserPostedView")
                        })
                    }
                    NavigationLink(value: selection[2]) {
                        VStack {
                            Text("999")
                            Text("팔로워")
                        }.onTapGesture(perform: {
                            print("팔로워")
                            path.append("FollowerView")
                        })
                    }
                    NavigationLink(value: selection[3]) {
                        VStack {
                            Text("100")
                            Text("팔로잉")
                        }.onTapGesture(perform: {
                            print("팔로잉")
                            path.append("FollowingView")
                        })
                    }
                    
                } // HSTACK
                Spacer()
            } // VSTACK
            .padding()
            
            .navigationDestination(for: String.self, destination: { num in
                if num == "UserProfileView" {
                    Text(num)
                    UserProfileView()
                } else if num == "UserPostedView" {
                    UserPostedView()
                } else if num == "FollowerView" {
                    FollowerFollowingView(selectedTab: .follower)
                } else if num == "FollowingView" {
                    FollowerFollowingView(selectedTab: .following)
                } else if num == "SettingView" {
                    SettingView(path: $path)
                }
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("마이페이지")
                        .bold()
                }
                ToolbarItem {
                    NavigationLink(value: selection[4]) {
                        Image(systemName: "gear")
                            .onTapGesture(perform: {
                                print("설정뷰")
                                path.append("SettingView")
                                print("설정뷰2")
                            })
                    }
                    
                }
            }
            
        }

    }
}

#Preview {
    ProfileView()
}
