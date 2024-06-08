//
//  MainViewMusicContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct MainViewMusicContainer: View {
    
    @EnvironmentObject var musicPlayerModel: MusicPlayer
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Button {
                print("button")
                // cksdud3786!@
                musicPlayerModel.getTest(url: Constants().currentmusic!)
            } label: {
                VStack {
                    Image(systemName: "forward.fill")
                        .foregroundStyle(.red)
                        .padding(.all, 3)
                    
                    Text("운동시작")
                        
                }.frame(width: 100, height: 80)
            }
            .foregroundStyle(.gray)
            .background(.lightgreen)
            .padding(.trailing, 10)
            

            Spacer()
            
            NavigationLink {
                MusicAllListView()
            } label: {
                Text("전체노래")
                    .frame(width: 100, height: 80)
            }
            .foregroundStyle(.gray)
            .background(.cyan)
            .padding(.horizontal, 10)
            
            Spacer()
            
            NavigationLink {
                
            } label: {
                Text("전체노래")
                    .frame(width: 100, height: 80)
            }
            .foregroundStyle(.gray)
            .background(.indigo)
            .padding(.horizontal, 10)
            
            Spacer()

        }.padding()
    }
}

#Preview {
    MainViewMusicContainer()
}
