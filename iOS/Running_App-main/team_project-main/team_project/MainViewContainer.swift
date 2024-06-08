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
    //    @StateObject var soundManager: MusicPlayer = MusicPlayer() // 되는거
    @EnvironmentObject var soundManager: MusicPlayer
    @EnvironmentObject var timer: TimerManager
    @Query var exerciseData: [ExerciseRoutineContainer]

    
    //    @EnvironmentObject private var connect: iOSToWatch
    @State private var pressed: Bool = false
    @State private var alert: Bool = false
    
//    @Query var exerciseRecord: [ExerciseRecordContainer]
    
    // MARK: - FUNCTIONS
    
    // MARK: - BODY
    
    var body: some View {
        NavigationStack {
            
                
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
                    
                    
                    
                    MyRoutineView(exerciseData: exerciseData)
                    
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
                
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try? AVAudioSession.sharedInstance().setActive(true)
            }

            
            .overlay {
                if timer.timerOn && timer.stopped {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea() // 화면 전체를 커버합니다.
                            .allowsHitTesting(true) // 이 뷰가 사용자 입력을 받도록 합니다.
                            .onTapGesture {
                                // 운동 취소 안한다
                                alert = false
                            }

                        // 커스텀 알림창 뷰입니다. alert 상태가 true일 때만 보여집니다.
                        ExerciseAlertView()
                            
                    }
            }

    }
}


#Preview {
    MainViewContainer()
        .modelContainer(PreviewContainer.container)
        .environmentObject(TimerManager())
    
    //    MainViewContainer(soundManager: MusicPlayer())
    //        .environmentObject(iOSToWatch())
}

