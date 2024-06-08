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
    @EnvironmentObject var timer: TimerManager
    
    //    @EnvironmentObject private var connect: iOSToWatch
    @State private var pressed: Bool = false
    @State private var alert: Bool = false
    @Environment(NavigationObject.self) private var path
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.isPresented) var presented

    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        @Bindable var path = path
        NavigationStack(path: $path.path) {
            
                VStack {
                    HeaderView()
                    
                    UserInfoViewContainer()
                    

                    MainViewMusicContainer()
                    
                    HStack(alignment:.bottom) {
                        Text("내 루틴")
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.horizontal)
                    
                    MyRoutineView()
                    
                    
                    // 만약 타이머가 작동중이라면 하단에 현재 시간을 나타낸다.
                    if timer.timerOn {
                        
                        NavigationLink {
                            if let data = timer.exerciseRoutineContainer {
                                RoutineListView(exerciseContainer: data)
                                    .onAppear {
                                        print("abc")
                                    }
                            }
                        } label: {
                            if let data = timer.exerciseRoutineContainer {
                                TimerView(exerciseContainer: data)
                            }
                            
                        }
                        
                        
                    } else {
                        HStack { // 만약 타이머가 작동중이라면 안보이게한다
                            Spacer()
                            
                            NavigationLink {
                                AddingRoutineView()
                            } label: {
                                Text("루틴추가")
                                    .foregroundStyle(.white)
                                    .padding(20)
                            }

                        }
                    }
                }
            }


            .onAppear {
                print("시작")
                path.tab = true
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try? AVAudioSession.sharedInstance().setActive(true)
            }
            
            .overlay {
                if timer.timerOn && timer.stopped {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea() // 화면 전체를 커버합니다.
                            .allowsHitTesting(true) // 이 뷰가 사용자 입력을 받도록 합니다.

                        // 커스텀 알림창 뷰입니다. alert 상태가 true일 때만 보여집니다.
                    ExerciseAlertView()
                            
                    }
            }
            .toolbar(path.tab ? .visible : .hidden, for: .tabBar)

    }
}


#Preview { @MainActor in
    MainViewContainer()
        .environmentObject(TimerManager())
        .modelContainer(previewRoutineContainer)
        .environment(NavigationObject())
    
    
    
    //    MainViewContainer(soundManager: MusicPlayer())
    //        .environmentObject(iOSToWatch())
}

