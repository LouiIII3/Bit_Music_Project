//
//  MainView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI
import AVFAudio
import SwiftData

struct MainViewContainer: View {
    
    // MARK: - PROPERTIES
    @Environment(TimerManager.self) var timer
    @Environment(NavigationObject.self) private var path
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        @Bindable var path = path
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        
                        MainViewMusicContainer()
                        
                        HStack(alignment:.bottom) {
                            Text("내 루틴")
                                .font(.title)
                                .bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        MyRoutineView()
                        
                        Spacer()
                        
                    } //VSTACK
                } //SCROLL
                .frame(minWidth: geometry.size.width, minHeight: geometry.size.height)
                
                .onAppear {
                    print("시작")
                    try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    try? AVAudioSession.sharedInstance().setActive(true)
                }
                .onAppear {
                    path.tab = false
                }
            } //GeometryReader
            .overlay(alignment: .bottomTrailing) {
                if !timer.showTimer {
                    
                    HStack {
                        Spacer()
                        NavigationLink {
                            AddingRoutineView()
                        } label: {
                            Text("루틴추가")
                                .foregroundStyle(.white)
                        }
                        .clipShape(.buttonBorder)
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(Color.primary1)
                        .padding(.bottom, 60)
                    }.padding()
                }
        }
        }
//        .background(.bg100)
    }
}


#Preview { @MainActor in
    NavigationStack {
        MainViewContainer()
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .environment(TimerManager())
            .environmentObject(NavigationObject())
    }
}
