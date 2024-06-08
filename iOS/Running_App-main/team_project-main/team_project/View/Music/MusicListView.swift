//
//  MusicListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI

struct MusicListView: View {
    
    @State var data: [MusicInfoModel]
    @EnvironmentObject var musicManager: MusicPlayer
    
    var body: some View {
        List(data) { data in
            HStack {
                Text(data.title)
                    .padding()
                Text(data.artist)
                    .padding()
            }
        }
        .onAppear {
            musicManager.getMusicInfo { result in
                data = result
            }
        }
    }
}

#Preview {
    MusicListView(data: .init())
}
