//
//  MusicAllListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct MusicAllListView: View {
    
    @EnvironmentObject var musicPlayer: MusicPlayer
    
    
    var body: some View {
        
        
        List(musicPlayer.musicContainer) { music in
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
            }
        }.onAppear {
            musicPlayer.getAllTest(url: Constants().getAllMusic!)
        }
        .onChange(of: musicPlayer.musicContainer) { oldValue, newValue in
            print("값이 수정되었다 \(oldValue.count) + \(newValue.count)")
        }
    }
}

#Preview {
    MusicAllListView()
}
