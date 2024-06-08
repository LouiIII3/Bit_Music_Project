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
    @EnvironmentObject var timer: TimerManager
    @Environment(NavigationObject.self) private var path
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
            
            let recordContainer = ExerciseRecordContainer(startDate: timer.startTime ?? Date(), endDate: timer.endTime ?? Date(), totalTime: Int(timer.elapsedTime), routineName: routineContainer.routineName, exerciseRecordModel: recordDataModel)
            
            dbContext.insert(recordContainer)
        }
//
    }
    
    
    var body: some View {
        ZStack {
            Color.darkRed
            VStack {
                Image(systemName: timer.stopped ? stoppedImage : pausedImage)
                    .foregroundStyle(.red)
                    .padding(.top)
                
                Text(timer.stopped ? stoppedTitle : pausedTitle)
                    .padding()
                
                HStack {
                    Spacer()
                    Text(timer.stopped ? stoppedText : pausedText)
                        .lineLimit(nil)
                        .frame(height: 50)
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                
                
                HStack {
                    Button {
                        timer.resume()
                    } label: {
                        Text("취소")
                    }
                    .padding()
                    
                    Button {
                        timer.stop()
                        timer.stopped = true
                        saveRecord()

                        timer.timerOn = false
                        path.path.removeLast()
                    } label: {
                        Text("확인")
                    }
                }
            }
        }
        .frame(width: 300, height: 230)
        .clipShape(.rect(cornerRadius: 40))
        .shadow(radius: 10)
        .transition(.scale) // 알림창 등장 애니메이션. 원하는 대로 변경 가능
        
    }
}

struct ExerciseAlertScreen: View {
    var body: some View {
        ExerciseAlertView()
            .environmentObject(TimerManager())
            .modelContainer(previewRoutineContainer)

    }
}

#Preview { @MainActor in
    ExerciseAlertScreen()
}
