//
//  MusicInfoModal.swift
//  team_project
//
//  Created by Taewon Yoon on 3/31/24.
//

import SwiftUI
import SwiftData

struct MusicModelModal: View {
//    @Query var musicInfo: [MusicModel]
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var dbContext
    @Binding var music: MusicModel
    
    var musicImage: UIImage?
    var musicName: String = "개화"
    
    func delete() {
        dbContext.delete(music)
    }
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .dark))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                
                AsyncImage(url: URL(string: music.albumUrl)) { image in
                    image.image?.resizable()
                        .scaledToFit()
                }
                
                Text(music.title)
                    .padding()
                    .bold()
                
                
                HStack {
                    Button(action: {
                        print("노래 삭제")
                        delete()
                        dismiss()
                    }, label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.white)
                        Text("좋아요 표시된 곡에서 삭제")
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                }
                .frame(height: 50)
                
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "text.badge.plus")
                            .foregroundStyle(.white)
                        Text("플레이리스트에 추가하기")
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                }
                .frame(height: 50)
                
                HStack {
                    Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(.white)
                        Text("공유")
                            .foregroundStyle(.white)
                    })
                    
                    Spacer()
                }
                .frame(height: 50)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("닫기")
                        .foregroundStyle(.white)
                })
            }
            .padding()
            

        }
    }
}

struct MusicModelModalScreen: View {
    var body: some View {
        MusicModelModal(music: .constant(.init(id: 1, title: "개화", artist: "루시", albumUrl: "abc.com", filePath: "abcd.com", tempo: "빠름")))
            .environmentObject(MusicPlayer(iosToWatch: iOSToWatch()))
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .modelContainer(previewMusicContainer)
    }
}

#Preview { @MainActor in
    MusicModelModalScreen()
}

