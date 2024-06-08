//
//  MusicAllListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct MusicAllListView: View {
    
    @EnvironmentObject var musicPlayer: MusicPlayer
    @State var currentMusic: MusicInfoModel?
    
    
    var body: some View {
        
//        List(musicPlayer.musicContainer) { music in
        
        ZStack {
            if currentMusic != nil {
                AsyncImage(url: URL(string: currentMusic?.albumUrl ?? ""))
                    .opacity(0.1)
                    .ignoresSafeArea()
            }

            
            ScrollView {
//                ForEach(SampleData().musicInfo) { music in
                    ForEach(musicPlayer.musicContainer) { music in
                    Button(action: {
                        // 노래 재생하기
                        currentMusic = music
                        musicPlayer.getWithoutBPM(url: URL(string: music.filePath) ?? URL(string: "")!)
                    }, label: {
                        HStack {
                            AsyncImage(url: URL(string: music.albumUrl)) { image in
                                image.image?.resizable()
                                    .scaledToFit()
                            }
                            .frame(width: 70, height: 70)
                            
                            VStack {
                                HStack {
                                    Text(music.title)
                                    Spacer()
                                }
                                HStack {
                                    Text(music.artist)
                                    Spacer()
                                }
                            }
                            Spacer()
                        }.foregroundStyle(.white)
                    })
                }
            }

        }
        .onAppear {
            musicPlayer.getAllTest(url: Constants().getAllMusic!)
        }
        .onChange(of: musicPlayer.musicContainer) { oldValue, newValue in
            print("값이 수정되었다 \(oldValue.count) + \(newValue.count)")
        }
    }
}

#Preview {
    MusicAllListView(currentMusic: MusicInfoModel(id: 1, title: "", artist: "", albumUrl: "", filePath: "", tempo: ""))
        .environmentObject(MusicPlayer(iosToWatch: iOSToWatch()))
}
