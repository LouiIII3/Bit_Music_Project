//
//  RoutineListCell.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI
import SwiftData

struct RoutineListView: View {
    
    var exerciseContainer: ExerciseRoutineContainer
//    var selected: ExerciseRoutineContainer
    @Environment(\.modelContext) var dbContext
    @EnvironmentObject var timeManager: TimerManager
    @EnvironmentObject var timer: TimerManager
    @State private var pressed = false
    @State private var paused = false
    
    
    func saveRecord() {
        
    }

    
    var body: some View {
        VStack {
            List(exerciseContainer.exerciseDefaultModel!) { selected in
                NavigationLink {
                    // selected는 운동루틴에 한 종류를 의미한다
                    RoutineRecordView(selectedExercise: selected, set: selected.set, count: selected.count, kg: selected.kg, done: selected.done)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(selected.exerciseName)")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            
                            HStack {
                                ForEach(selected.part) { part in
                                    Text(part.rawValue)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                        }
                        Spacer()
                        
                    }
                }
            }
            //timer.timerOn && timer.stopped
            HStack {
                Button(action: {
                    // 운동 시작 // 타이머가 꺼져있으면 타이머 시작 // 타이머가 켜져있으면 중단
                    if timeManager.timerOn {
                        timeManager.stop()
                    } else {
                        timeManager.exerciseRoutineContainer = exerciseContainer
                        timeManager.start()
                    }
                }, label: { // 타이머가 작동중이면서 중지되지 않았다면
                    Text(timeManager.timerOn ? "운동 종료" : "운동 시작")
                        .bold()
                        .foregroundStyle(.white)
                })
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(timeManager.timerOn ? .green : .red)
                .foregroundStyle(Color.white)
                
                
                NavigationLink {
                    AddingRoutineView(exercise: exerciseContainer)
                } label: {
                    Text("운동 추가")
                        .bold()
                        .foregroundStyle(.white)
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.red)
                .foregroundStyle(Color.white)


            }
            
            
        }
        .overlay {
            if timer.timerOn && timer.stopped {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea() // 화면 전체를 커버합니다.
                        .allowsHitTesting(true) // 이 뷰가 사용자 입력을 받도록 합니다.
                        .onTapGesture {
                            // 운동 취소 안한다
                            
                        }

                    // 커스텀 알림창 뷰입니다. alert 상태가 true일 때만 보여집니다.
                    ExerciseAlertView()
                        
                }
        }


    }
}

//#Preview {
//    RoutineListView(exerciseContainer: PreviewData().previewExerciseRoutineContainer, selected: PreviewData().previewExerciseRoutineContainer)
//        .environmentObject(TimerManager())
//    
////        .modelContainer(PreviewContainer.container)
//}
