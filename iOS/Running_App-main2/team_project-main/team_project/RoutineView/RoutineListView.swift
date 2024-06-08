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
    @Environment(\.modelContext) private var dbContext
    @Environment(TimerManager.self) var timer
    @State private var pressed = false
    @State private var selected: ExerciseDefaultModel = SampleData.exerciseDefaultModel.first!
    var modifiy = false

    //MARK: FUNC
    
    func removeList(at offsets: IndexSet) {
        for i in offsets {
            if let data = exerciseContainer.exerciseDefaultModel?[i] {
                dbContext.delete(data)
            }
        }
        
    }
    
    var body: some View {
        ZStack {

            ReusableListView(pressed: $pressed, selected: $selected, exerciseModels: exerciseContainer.exerciseDefaultModel!)
            .sheet(isPresented: $pressed, content: {
                ExerciseModalView(exerciseContainer: exerciseContainer, exercise: $selected)
                    .presentationDetents([.fraction(0.20)])
            })
            .overlay(alignment: .bottom) {
                if !modifiy {
                    HStack {
                        Button(action: {
                            if timer.isStarted {
                                timer.prepareCanceling()
                            } else { // 타이머 작동시키기
                                timer.exerciseRoutineContainer = exerciseContainer
                                timer.startTimer()
                                timer.startTime = Date()
                            }
                        }, label: { // 타이머가 작동중이면서 중지되지 않았다면
                            Text(timer.isStarted ? "운동 종료" : "운동 시작")
                                .bold()
                                .foregroundStyle(.white)
                        })
                        .buttonStyle(BorderedProminentButtonStyle())
                        .tint(timer.isStarted ? .green : .red)
                        .foregroundStyle(Color.white)
                        .frame(width: 100, height: 50)
                        
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
                        .frame(width: 100, height: 50)

                    } //HSTACK
                }
            }
            .overlay {
                if timer.showAlert {
                    ExerciseAlertView()
                }
            }
            .navigationTitle(exerciseContainer.routineName)
            .navigationDestination(for: String.self) { exercise in
                if exercise == "" {
                    
                }
            }
        }
        
    }
}

struct RoutineListScreen: View {
    
    @Query private var routineContainer: [ExerciseRoutineContainer]
    
    var body: some View {
        NavigationStack {
            RoutineListView(exerciseContainer: routineContainer[0])
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        RoutineListScreen()
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .environment(TimerManager())
            .environmentObject(NavigationObject())
    }
}


struct ExerciseModalView: View {
    var exerciseContainer: ExerciseRoutineContainer
    @Environment(\.modelContext) private var dbContext
    @Binding var exercise: ExerciseDefaultModel
    @Environment(\.dismiss) private var dismiss

    func removeExercise() {
        exerciseContainer.exerciseDefaultModel?.removeAll(where: { ExerciseDefaultModel in
            ExerciseDefaultModel.exerciseName == exercise.exerciseName
        })
        dbContext.insert(exerciseContainer)
    }
    
    var body: some View {
        
        Button(action: {
            removeExercise()
            print("삭제하기")
            self.dismiss()
        }, label: {
            HStack {
                Image(systemName: "trash")
                    .foregroundStyle(.white)
                
                Text("루틴삭제")
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
        })
        .contentShape(Rectangle())
        .padding()
        
        Button(action: {}, label: {
            HStack {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(.white)
                
                Text("루틴 공유하기")
                    .foregroundStyle(.white)
                
                Spacer()
            }
            
        })
        .contentShape(Rectangle())
        .padding()
        
        
    }
}

struct ExerciseModalScreen: View {
    
    var body: some View {
        NavigationStack {
            ExerciseModalScreen()
                .modelContainer(previewRoutineContainer)
                .modelContainer(previewRecordContainer)
                .environment(TimerManager())
                .environmentObject(NavigationObject())
        }
    }
}
