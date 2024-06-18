//
//  MainViewMusicContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI


enum MainViewMusicButtonItem {
    case heartrate
    case allMusic
    case favorite
    
    var title: String {
        switch self {
        case .heartrate:
            return "심박수"
        case .allMusic:
            return "전체노래"
        case .favorite:
            return "즐겨찾기"
        }
    }
    
    var image: String {
        switch self {
        case .heartrate:
            return "forward.fill"
        case .allMusic:
            return "music.note.list"
        case .favorite:
            return "star.fill"
        }
    }
    
    var imageColor: Color {
        switch self {
        case .heartrate:
            return .accent1
        case .allMusic:
            return .green
        case .favorite:
            return .yellow
            
        }
    }
}

struct MusicButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .foregroundStyle(.gray)
            .background(.darkBlack2)
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct MainViewMusicContainer: View {
    @EnvironmentObject var musicPlayerModel: MusicPlayer
    @State private var toggle: Bool = false
    
    var body: some View {
        
        HStack {
            makeButton(buttonItem: .heartrate)
            
            Spacer()
            
            makeNavigationLink(buttonItem: .allMusic)
            
            Spacer()
            
            makeNavigationLink(buttonItem: .favorite)
            
        }
        
        .padding()
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
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .environment(TimerManager())
            .environmentObject(NavigationObject())
    }
}


extension MainViewMusicContainer {
    func makeButton(buttonItem: MainViewMusicButtonItem) -> some View {
        Button {
            if let bpm = musicPlayerModel.iosToWatch.bpm {
                //                    musicPlayerModel.playSound()
                musicPlayerModel.getTest(url: Constants().currentmusic!, bpm: bpm)
            } else {
                toggle.toggle()
            }
        } label: {
            VStack {
                Image(systemName: buttonItem.image)
                    .foregroundStyle(buttonItem.imageColor)
                    .padding(.all, 3)
                
                Text(buttonItem.title)
                    .foregroundStyle(.text1)
            }
            .frame(width: 100, height: 100)
        }
        .buttonStyle(MusicButtonStyle())
    }
    
    func makeNavigationLink(buttonItem: MainViewMusicButtonItem) -> some View {
        NavigationLink {
            switch buttonItem {
            case .heartrate:
                Text("")
            case .allMusic:
                MusicAllListView()
            case .favorite:
                FavoriteMusicView()
            }
        } label: {
            VStack {
                Image(systemName: buttonItem.image)
                    .foregroundStyle(buttonItem.imageColor)
                    .padding(.all, 3)
                
                Text("전체노래")
                    .foregroundStyle(.white)
                
            }
            .frame(width: 100, height: 100)
        }
        .buttonStyle(MusicButtonStyle())
    }
}
