//
//  RoutineStatusView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/27/24.
//

import SwiftUI

struct RoutineStatusView: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터
    var height = 0
    var weight = 0
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(1..<selectedExercise.set+1, id: \.self) { num in
                    Button(action: {
                        selectedExercise.done[num-1].toggle()
                    }, label: {
                        HStack {
                            Text("\(num)세트").font(.system(size: 13)).padding(.trailing).foregroundStyle(.white)
                            Text("\(selectedExercise.kg[num-1])kg").font(.system(size: 13)).foregroundStyle(.white)//.padding(0)
                            Text("\(selectedExercise.count[num-1])개").font(.system(size: 13)).foregroundStyle(.white).padding(.leading, 10)
                            
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
            
        }
        .navigationTitle(selectedExercise.exerciseName)
        .containerBackground(.red.gradient, for: .navigation)
        .padding()
    }
}

struct RoutineStatusScreen: View {
    
    var body: some View {
        NavigationStack {
            
            RoutineStatusView(selectedExercise: SampleData.exerciseDefaultModel.first!)
                .environmentObject(WorkoutManager())
                .environmentObject(WatchToiOS())
                .modelContainer(previewRoutineContainer)
                .containerBackground(.red.gradient, for: .navigation)

        }
        
    }
}

#Preview {
    RoutineStatusScreen()
}
