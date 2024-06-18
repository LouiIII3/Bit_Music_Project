//
//  MyRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct MyRoutineView: View {
    @Environment(\.modelContext) private var dbContext
    @Query var exerciseData: [ExerciseRoutineContainer] // 모든 루틴이 들어있는 컨테이너
    @State private var pressed: Bool = false
    @State var selectedRoutine: ExerciseRoutineContainer = SampleData.routineContainer.first!
    
    var body: some View {
        exerciseListCell
        .navigationDestination(for: ExerciseRoutineContainer.self, destination: { exercise in
            RoutineListView(exerciseContainer: exercise)
        })
        .sheet(isPresented: $pressed, content: {
            RoutineModalView(routine: $selectedRoutine, exerciseData: exerciseData)
                .presentationDetents([.fraction(0.20)])
        })
        
    }
    
    func removeList(at offsets: IndexSet) {
        for i in offsets {
            let data = exerciseData[i]
            dbContext.delete(data)
        }
    }
    
    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    private func updateExerciseParts(from exercise: ExerciseRoutineContainer) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.exerciseDefaultModel?.forEach { ExerciseModel in
            ExerciseModel.part.forEach({ ExercisePart in
                partsSet.insert(ExercisePart)
            })
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}

extension MyRoutineView {
    var exerciseListCell: some View {
        VStack {
            ForEach(exerciseData.sorted(by: { ex1, ex2 in ex1.routineName < ex2.routineName }), id: \.self) { exercise in
                HStack {
                    // 이미지 집어넣는곳
                    NavigationLink(value: exercise) {
                        VStack {
                            HStack {
                                Text(exercise.routineName)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .font(.title)
                                Spacer()
                            }
                            // 파트 목록을 표시
                            HStack {
                                ForEach(updateExerciseParts(from: exercise), id: \.self) { data in
                                    Text(data.rawValue)
                                        .foregroundStyle(.green)
                                }
                                Spacer()
                            } //HSTACK
                        } //VSTACK
                    } //NAVI
                    
                    Spacer()
                    
                    Button(action: {
                        selectedRoutine = exercise
                        self.pressed.toggle()
                    }, label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.white)
                    })
                } // HSTACK
                .padding()
                .background(.darkBlack2)
                .clipShape(.buttonBorder)
            }
            .padding(.horizontal,10)
            .padding(.vertical, 5)
            Spacer()
        } //VSTACK
    }
}

struct RoutineContainerScreen: View {
    @Query var exerciseData: [ExerciseRoutineContainer] // 모든 루틴이 들어있는 컨테이너
    
    var body: some View {
        NavigationStack {
            
            MyRoutineView(selectedRoutine: SampleData.routineContainer.first!)
                .modelContainer(previewRoutineContainer)
                .modelContainer(previewRecordContainer)
                .environment(TimerManager())
                .environmentObject(NavigationObject())
        }
    }
}

#Preview { @MainActor in
    RoutineContainerScreen()
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .environment(TimerManager())
        .environmentObject(NavigationObject())
    
}

struct RoutineModalView: View {
    @Environment(\.modelContext) private var dbContext
    @Binding var routine: ExerciseRoutineContainer
    var exerciseData: [ExerciseRoutineContainer]
    
    var body: some View {
        
        Button(action: {
            dbContext.delete(routine)
            
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
