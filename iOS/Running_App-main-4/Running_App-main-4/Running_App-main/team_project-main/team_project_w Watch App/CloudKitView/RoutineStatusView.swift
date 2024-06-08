//
//  RoutineStatusView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/27/24.
//

import SwiftUI

struct RoutineStatusView: View {
    @Environment(\.modelContext) private var dbContext
    @EnvironmentObject var connect: WatchToiOS

    var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터
    
    var height = 0
    var weight = 0
    
    func saveRoutine() {
        
        // 만일 새로운 데이터라면
        
        if let data = selectedExercise.exerciseRoutineContainer {
            print("워치에서 변경사항 저장하기")
            dbContext.insert(data)
//            connect.sendMessage(message: ["update":true])
            do {
                try dbContext.save()
            } catch {
                print("워치에서 변경사항 저장하는데 에러 발생:\(error)")
            }
        }
        
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1..<selectedExercise.set+1, id: \.self) { num in
                    Button(action: {
                        selectedExercise.done[num-1].toggle()
                        saveRoutine()
                    }, label: {
                        HStack {
                            Text("\(num)세트").padding(.trailing).foregroundStyle(.white)
                            Text("\(selectedExercise.kg[num-1])kg").foregroundStyle(.white)//.padding(0)
                            Text("\(selectedExercise.count[num-1])개").foregroundStyle(.white).padding(.leading, 10)
                            
                            Spacer()
                            
                            Image(systemName: selectedExercise.done[num-1] ? "checkmark.circle.fill" : "circle").padding(1)
                                .foregroundStyle(selectedExercise.done[num-1] ? .green : .gray)
                        }
                    })
                    .buttonBorderShape(.roundedRectangle)
                    .tint(selectedExercise.done[num-1] ? Color.green : Color.gray)
                }
                
                Spacer()
            } //VSTACK
            
        }.navigationTitle(selectedExercise.exerciseName)
    }
}

#Preview {
    NavigationStack {
        RoutineStatusView(selectedExercise: SampleData.exerciseDefaultModel.first!)
            .environmentObject(WorkoutManager())
            .environmentObject(WatchToiOS())
            .modelContainer(previewRoutineContainer)
    }
}
