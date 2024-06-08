//
//  MusicAllListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct MusicAllListView: View {
    
    @EnvironmentObject var musicPlayer: MusicPlayer
    @State private var pressed: Bool = false
    @State var selectedMusic: MusicInfoModel = MusicInfoModel(id: 1, title: "없습니다", artist: "없습니다", albumUrl: "없습니다", filePath: "없습니다", tempo: "없습니다")
    
    func alter(music: MusicModel) -> MusicInfoModel {
        let transferedData: MusicInfoModel = .init(id: music.id, title: music.title, artist: music.artist, albumUrl: music.artist, filePath: music.filePath, tempo: music.tempo)
            //.init(music: MusicInfoModel(id: music.id, title: music.title, artist: music.artist, albumUrl: music.albumUrl, filePath: music.filePath, tempo: music.tempo))
        return transferedData
    }
    
    var body: some View {
        
        ScrollView {
            ForEach(musicPlayer.musicContainer) { music in
//            ForEach(previewMusicInfo) { music in // 테스트용
                
                HStack {
                    Button(action: {
                        Task(priority: .high) {
                            await musicPlayer.setupMusicInfo(url: URL(string: music.filePath)!, info: music)
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
                                    Spacer()
                                }
                            }
                            Spacer()
                            
                        }
                        .foregroundStyle(.white)
                        
                    })
                    
                    Button {
                        self.selectedMusic = music
                        print(music)
                        pressed.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    }
                    .padding()

                }
                
            }
            .onAppear {
                musicPlayer.getAllTest(url: Constants().getAllMusic!)
            }
            .fullScreenCover(isPresented: $pressed, content: {
                    MusicInfoModal(music: $selectedMusic)
                        .presentationBackground(.clear)
            })
        }
    }
}

#Preview { @MainActor in
    MusicAllListView(selectedMusic: .init(id: 1, title: "개화", artist: "루시", albumUrl: "abc.com", filePath: "abcd.com", tempo: "빠름"))
        .environmentObject(MusicPlayer(iosToWatch: iOSToWatch()))
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .modelContainer(previewMusicContainer)
}


struct ClearBackground: UIViewRepresentable {
    
    public func makeUIView(context: Context) -> UIView {
        
        let view = ClearBackgroundView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    public func updateUIView(_ uiView: UIView, context: Context) {}
}


class ClearBackgroundView: UIView {
    open override func layoutSubviews() {
        guard let parentView = superview?.superview else {
            return
        }
        parentView.backgroundColor = .clear
    }
}
