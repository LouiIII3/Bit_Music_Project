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
//    @Query var exerciseRecordContainer: [ExerciseRoutineContainer]
    
    @EnvironmentObject var timer: TimerManager
    var pausedImage = "stop.fill"
    var pausedTitle = "운동 중단"
    var pausedText = "운동을 중단하면 기록이 저장되지 않습니다. 운동을 중단하시겠습니까?"
    
    var stoppedImage = "flag.fill"
    var stoppedTitle = "운동 완료"
    var stoppedText = "기록이 저장되고 결과 페이지로 이동합니다."
    
    
    func saveRecord() {
        
        timer.exerciseRoutineContainer?.exerciseDefaultModel!.forEach({ ExerciseDefaultModel in
            print("타이머값 count: \(ExerciseDefaultModel.count)")
            print("타이머값 kg: \(ExerciseDefaultModel.kg)")
            print("타이머값 done: \(ExerciseDefaultModel.done)")
        })
        
        
        if let recordDataModel = timer.exerciseRoutineContainer?.exerciseDefaultModel.map({ ec in
            return ec.map { ed in
                return ExerciseRecordModel(exerciseName: ed.exerciseName, part: ed.part, tool: ed.tool, set: ed.set, count: ed.count, kg: ed.kg, done: ed.done)
            }
        })
//        if let recordDataModel = timer.exerciseRoutineContainer?.exerciseDefaultModel.map({ ec in
//            return ExerciseRecordModel(exerciseName: ec.exerciseName, part: ec.part, tool: ec.tool, set: ec.set, count: ec.count, kg: ec.kg, done: ec.done)
//        }) 
        {
            recordDataModel.forEach { rm in
                print("기록록 count: \(rm.count)")
                print("기록록 kg: \(rm.kg)")
                print("기록록 done: \(rm.done)")
            }
            guard let startTime = timer.startTime, let endTime = timer.endTime else {
                return print("타이머의 측정 시간이 잘못되어 있다")
            }
            let recordContainer = ExerciseRecordContainer(startDate: startTime, endDate: endTime, totalTime: Int(timer.elapsedTime), routineName: "루틴이름1", exerciseRecordModel: recordDataModel)
            dbContext.insert(recordContainer)
            
            print("기록 저장완료")
            
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

#Preview {
    ExerciseAlertView()
}
