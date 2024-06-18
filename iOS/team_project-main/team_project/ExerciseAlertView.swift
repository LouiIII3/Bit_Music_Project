//
//  AlertView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI
import SwiftData

struct ExerciseAlertView: View {
    @Environment(\.modelContext) var dbContext
//    @EnvironmentObject var timer: TimerManager
    @Environment(TimerManager.self) var timer
    @Environment(NavigationObject.self) private var path
    @State var rotation: CGFloat = 0.0
    var pausedImage = "stop.fill"
    var pausedTitle = "운동 중단"
    var pausedText = "운동을 중단하면 기록이 저장되지 않습니다. 운동을 중단하시겠습니까?"
    
    var stoppedImage = "flag.fill"
    var stoppedTitle = "운동 완료"
    var stoppedText = "기록이 저장되고 결과 페이지로 이동합니다."
    
    
    func saveRecord() {
        
        timer.exerciseRoutineContainer?.exerciseDefaultModel?.forEach({ ExerciseDefaultModel in
            print("저장할 타이머값 count: \(ExerciseDefaultModel.count)")
            print("저장할 타이머값 kg: \(ExerciseDefaultModel.kg)")
            print("저장할 타이머값 done: \(ExerciseDefaultModel.done)")
        })
        
        if let routineContainer = timer.exerciseRoutineContainer {
            guard let recordDataModel = routineContainer.exerciseDefaultModel?.map({ ED in
                return ExerciseRecordModel(exerciseName: ED.exerciseName, part: ED.part, tool: ED.tool, set: ED.set, count: ED.count, kg: ED.kg, done: ED.done)
            }) else {
                print("안된다 기록 데이터 모델이 비어있음")
                return
            }
            
            let recordContainer = ExerciseRecordContainer(startDate: timer.startTime ?? Date(), endDate: timer.endTime ?? Date(), totalTime: Int(timer.timeRemaining), routineName: routineContainer.routineName, exerciseRecordModel: recordDataModel)
            
//            let recordContainer = ExerciseRecordContainer(startDate: timer.startTime ?? Date(), endDate: timer.endTime ?? Date(), totalTime: Int(timer.time), routineName: routineContainer.routineName, exerciseRecordModel: recordDataModel)
            
            dbContext.insert(recordContainer)
        }
//
    }
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 300, height: 240)

            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 150, height: 400)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.gray)]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 7)
                        .frame(width: 296, height: 236)
                }
            
            VStack {
                
//                Image(systemName: timer.stopped ? stoppedImage : pausedImage)
                Image(systemName: timer.isStarted ? pausedImage : stoppedImage)
                    .foregroundStyle(.red)
                    .padding(.top)
                
//                Text(timer.stopped ? stoppedTitle : pausedTitle)
                Text(timer.isStarted ? pausedTitle : stoppedTitle)
                    .padding()
                
                HStack {
                    Spacer()
//                    Text(timer.stopped ? stoppedText : pausedText)
                    Text(timer.isStarted ? pausedText : stoppedText)
                    
                        .lineLimit(nil)
                        .frame(height: 50)
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                
                
                HStack {
                    Button {
//                        timer.resume()
                        timer.showAlert = false
                        timer.startTimer()
//                        timer.pauseOrResumeTimer()
                    } label: {
                        Text("취소")
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    Button {
//                        timer.stop()
                        timer.cancelTimer()
//                        timer.stopped = true
                        saveRecord()
//                        timer.timerOn = false
                    } label: {
                        Text("확인")
                            .foregroundStyle(.white)
                    }
                }
            }
            .frame(width: 290, height: 233)
            .clipShape(.rect(cornerRadius: 40))
            .shadow(radius: 10)
            .transition(.scale) // 알림창 등장 애니메이션. 원하는 대로 변경 가능
            .background(.black)
            .clipShape(.rect(cornerRadius: 20))
        }
        .onAppear {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
            timer.isStarted = true
        }

        
    }
}

struct ExerciseAlertScreen: View {
    var body: some View {
        ExerciseAlertView()
            .modelContainer(previewRoutineContainer)
            .environmentObject(NavigationObject())
            .environment(TimerManager())

    }
}

#Preview { @MainActor in
    ExerciseAlertScreen()
}
