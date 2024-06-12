//
//  ResuableListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/30/24.
//

import SwiftUI

struct ReusableListView: View {
    @Binding var pressed: Bool
    @Binding var selected: ExerciseDefaultModel
    var exerciseModels: [ExerciseDefaultModel]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(exerciseModels.sorted(by: { ed1, ed2 in
                    return ed1.exerciseName > ed2.exerciseName
                })) { exercise in
                    NavigationLink {
                        // selected는 운동루틴에 한 종류를 의미한다
                        RoutineRecordView(selectedExercise: exercise)//
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("\(exercise.exerciseName)")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.orange)
                                
                                HStack {
                                    ForEach(exercise.part) { part in
                                        Text(part.rawValue)
                                            .font(.footnote)
                                            .multilineTextAlignment(.leading)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                selected = exercise
                                pressed.toggle()
                            }, label: {
                                Image(systemName: "ellipsis")
                                    .foregroundStyle(.white)
                                
                            })
                        }
                    }
                    .padding()
                    .background(Color.darkBlack2)
                    .clipShape(.buttonBorder)
                } //LIST
                                
                Spacer()
                
            } //VSTACK
        }
        
    }
}

struct ReusableListSceen: View {
    var body: some View {
        NavigationStack {
            ReusableListView(pressed: .constant(false), selected: .constant(SampleData.exerciseDefaultModel.first!), exerciseModels: SampleData.exerciseDefaultModel)
                .modelContainer(previewRoutineContainer)
                .modelContainer(previewRecordContainer)
                .environment(TimerManager())
                .environmentObject(NavigationObject())
        }
    }
}

//#Preview { @MainActor in
//    NavigationStack {
//        RoutineListScreen()
//            .modelContainer(previewRoutineContainer)
//            .modelContainer(previewRecordContainer)
//            .environment(TimerManager())
//            .environmentObject(NavigationObject())
//    }
//}


#Preview { @MainActor in
    ReusableListView(pressed: .constant(false), selected: .constant(ExerciseDefaultModel(exerciseName: "hi", part: [.abs], tool: ExerciseTool.barbell)), exerciseModels: SampleData.exerciseDefaultModel)
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .environment(TimerManager())
        .environmentObject(NavigationObject())
}

