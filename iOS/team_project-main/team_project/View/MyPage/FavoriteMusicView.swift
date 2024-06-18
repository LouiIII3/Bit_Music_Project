//
//  FavoriteMusicView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/31/24.
//

import SwiftUI
import SwiftData

struct FavoriteMusicView: View {
    @EnvironmentObject var musicPlayer: MusicPlayer
    @Query var musicContainer: [MusicModel]
    @State private var pressed: Bool = false
    @State var selectedMusic: MusicModel = .init(id: 0, title: "", artist: "", albumUrl: "", filePath: "", tempo: "")
    
    
    func alter(music: MusicModel) -> MusicInfoModel {
        let transferedData: MusicInfoModel = .init(id: music.id, title: music.title, artist: music.artist, albumUrl: music.artist, filePath: music.filePath, tempo: music.tempo)
        return transferedData
    }
    
    var body: some View {
        GeometryReader(content: { geometry in
                        
            ScrollView(.vertical) {
                
                VStack {
                    
                    Rectangle()
                        .frame(height: geometry.size.height * 0.2)
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottomTrailing))
                        .opacity(0.5)

                    
                    Spacer()
                    
                    ForEach(musicContainer) { music in
                        musicListCell(music: music)
                    }
                }
                .fullScreenCover(isPresented: $pressed, content: {
                    MusicModelModal(music: $selectedMusic)
                        .presentationBackground(.clear)
                })
            }
            .ignoresSafeArea()
//            .background(Color.backgroundColor1)
            .navigationTitle("좋아요 표시한 곡")
        })
    }
    
}

extension FavoriteMusicView {
    func musicListCell(music: MusicModel) -> some View {
        HStack {
            Button(action: {
                Task(priority: .high) {
                    await musicPlayer.setupMusicInfo(url: URL(string: music.filePath)!, info: alter(music: music))
                }
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
                                .foregroundStyle(.gray)
                            Spacer()
                        }
                    }
                    Spacer()
                }
                .foregroundStyle(.white)
            })
            
            Button {
                self.selectedMusic = music//alter(music: music)
                pressed.toggle()
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
            .padding()
        }
    }
}


struct FavoriteMusicScreen: View {
    var body: some View {
        NavigationStack {
            
            FavoriteMusicView(selectedMusic: .init(id: 1, title: "123", artist: "1234", albumUrl: "ac.com", filePath: "acp.com", tempo: "fast"))
                .environmentObject(NavigationObject())
                .modelContainer(previewMusicContainer)
        }
    }
}

#Preview { @MainActor in
    FavoriteMusicScreen()
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .environment(TimerManager())
        .environmentObject(NavigationObject())
}

