//
//  ControlView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import SwiftData

struct ControlView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.modelContext) var dbContext
    var exerciseContainer: ExerciseRoutineContainer
    
    func saveRoutine() {
        
        // 만일 새로운 데이터라면
        
        
        guard let recordDataModel = exerciseContainer.exerciseDefaultModel?.map({ ED in
            return ExerciseRecordModel(exerciseName: ED.exerciseName, part: ED.part, tool: ED.tool, set: ED.set, count: ED.count, kg: ED.kg, done: ED.done)
        }) else {
            print("안된다 기록 데이터 모델이 비어있음")
            return
        }
        
        let routineContainer = ExerciseRecordContainer(startDate: workoutManager.builder?.startDate ?? Date(), endDate: workoutManager.builder?.endDate ?? Date(), totalTime: Int(workoutManager.builder?.elapsedTime ?? 0), routineName: exerciseContainer.routineName, exerciseRecordModel: recordDataModel)
        
        dbContext.insert(routineContainer)
        
        
    }
    
    var body: some View {
        
        HStack {
            Button {
                saveRoutine()
                workoutManager.endWorkout()
                // 현재 루틴 새로 저장하기
                
            } label: {
                Text("종료")
                    .foregroundStyle(.red)
            }
            
            Button {
                workoutManager.togglePause()
            } label: {
                Text(workoutManager.running ? "중단" : "재개")
                    .foregroundStyle(workoutManager.running ? .yellow : .green)
            }
        }
    }
}

#Preview {
    ControlView(exerciseContainer: SampleData.routineContainer.first!)
        .environmentObject(WorkoutManager())
}
