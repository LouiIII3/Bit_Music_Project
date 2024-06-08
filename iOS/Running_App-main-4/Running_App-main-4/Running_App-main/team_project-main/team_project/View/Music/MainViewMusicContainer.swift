//
//  MainViewMusicContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct MainViewMusicContainer: View {
    @EnvironmentObject var musicPlayerModel: MusicPlayer
//    @EnvironmentObject var iosToWatch: iOSToWatch
    @State private var toggle: Bool = false
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Button {
                print("button")
                // 심박수 요청하기 // 음악 시작하기 //
                if let bpm = musicPlayerModel.iosToWatch.bpm {
//                    musicPlayerModel.playSound()
                    musicPlayerModel.getTest(url: Constants().currentmusic!, bpm: bpm)
                } else {
                    print("값확인중:\(String(describing: musicPlayerModel.iosToWatch.bpm))")
                    toggle.toggle()
                }
                
            } label: {
                VStack {
                    Image(systemName: "forward.fill")
                        .foregroundStyle(.red)
                        .padding(.all, 3)
                    
                    Text("심박수 노래듣기")
                        
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
            .alert("워치로 심박수가 측정되지 않습니다", isPresented: $toggle) {
                Button(action: {}, label: {
                    Text("확인")
                })
            }
    }
}

#Preview {
    NavigationStack {
        MainViewMusicContainer()
            .environmentObject(MusicPlayer(iosToWatch: iOSToWatch()))
            .environmentObject(iOSToWatch())
    }
}
