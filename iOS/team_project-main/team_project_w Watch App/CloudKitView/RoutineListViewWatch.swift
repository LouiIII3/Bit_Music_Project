//
//  RoutineListViewWatch.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/26/24.
//

import SwiftUI

struct RoutineListViewWatch: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
    var exerciseContainer: ExerciseRoutineContainer

    var body: some View {
        VStack {
            
            List(exerciseContainer.exerciseDefaultModel ?? [ExerciseDefaultModel(exerciseName: "", part: [], tool: .none)]) { selected in
                NavigationLink {
                    // selected는 운동루틴에 한 종류를 의미한다
                    RoutineStatusView(selectedExercise: selected)
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
        }.padding()
    }
}

struct RoutineListViewScreen: View {
    
    var body: some View {
        NavigationStack {
            
            RoutineListViewWatch(exerciseContainer: SampleData.routineContainer.first!)
                .environmentObject(WorkoutManager())
                .environmentObject(WatchToiOS())
                .modelContainer(previewRoutineContainer)
                .containerBackground(.red.gradient, for: .navigation)
        }
        
    }
}

#Preview {
    RoutineListViewScreen()
}
