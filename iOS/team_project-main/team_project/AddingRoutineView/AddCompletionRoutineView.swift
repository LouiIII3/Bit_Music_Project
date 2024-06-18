//
//  AddCompletionRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI
import SwiftData

struct AddCompletionRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var dbContext
    @Binding var addingExercises: [ExerciseDefaultModel]
    //    @Query var exerciseData: ExerciseRoutineContainer
    @State var alert: Bool = false
    @State var title: String = ""
    @State private var selected: ExerciseDefaultModel = SampleData.exerciseDefaultModel.first!
    @State private var pressed = false

    var exercise: ExerciseRoutineContainer? // 만약에 기존에 있던 저장소에 추가하려면 존재 / 처음이라면 nil이 들어있을 것임
    
    func saveRoutine(routineName: String, completion: @escaping (Bool) -> Void) {
        // 기존에 있던 데이터라면 기존 데이터를 수정한다
        if let data = exercise, let model = data.exerciseDefaultModel {
            // exericse에 데이터가 존재하지 않는다면 이미 존재하는 루틴 알림을 띄워야하기 때문에 false
            let models = addingExercises + model
            print("여기 제대로 실행됐는데??")
            data.exerciseDefaultModel = models
            dbContext.insert(data)
            return completion(true)
        }

        // 만약 메인뷰에서 루틴 추가 버튼을 눌러서 들어왔을 경우 logic
        let predicate = #Predicate<ExerciseRoutineContainer> { $0.routineName == routineName }
        let descriptor = FetchDescriptor<ExerciseRoutineContainer>(predicate: predicate)
        if let count = try? dbContext.fetchCount(descriptor), count > 0 {
            return completion(false) // false여야 알림이 뜬다
        }
        
        // 만일 새로운 데이터라면
        let newExerciseRoutineContainer = ExerciseRoutineContainer(routineName: routineName, exerciseDefaultModel: addingExercises)
        dbContext.insert(newExerciseRoutineContainer)
        return completion(true)
    }
    
    func removeExercise(index: IndexSet) {
        addingExercises.remove(atOffsets: index)
    }
    
    var body: some View {
        VStack {
            if let name = exercise?.routineName {
                HStack {
                    TextField(name, text: $title)
                        .font(.system(size: 25))
                    
                }.padding()
            } else {
                HStack {
                    TextField("루틴 이름을 설정하세요", text: $title)
                        .font(.system(size: 25))
                    
                }.padding()
            }
            
            if let model = exercise?.exerciseDefaultModel {
                ReusableListView(pressed: $pressed, selected: $selected, exerciseModels: model + addingExercises)
            } else {
                ReusableListView(pressed: $pressed, selected: $selected, exerciseModels: addingExercises)
            }

            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis")
                }
                
                
            }
        }
        .alert("존재하는 루틴이름입니다" ,isPresented: $alert) {
            Button("확인", role: .destructive) {
                
            }
        }
        .overlay {
            VStack {
                Spacer()
                Button {
                    print("루틴 저장하기")
                    saveRoutine(routineName: title) { result in
                        if !result {
                            alert.toggle()
                        } else {
                            dismiss()
                        }
                    }
                } label: {
                    if exercise != nil {
                        Text("루틴수정")
                    } else {
                        Text("루틴저장")
                    }
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .tint(.green)
                
            }
        }
        .onAppear(perform: {
            if let existExerciseName = exercise?.routineName {
                title = existExerciseName
            }
        })
        .sheet(isPresented: $pressed, content: {
            if let deleteExercise = exercise?.exerciseDefaultModel, let exerciseContainer = exercise {
                if deleteExercise.count > 0 {
                    ExerciseModalView(exerciseContainer: exerciseContainer, exercise: $selected)
                }
            }
        })
    }
}

struct AddCompletionRoutineScreen: View {
    var body: some View {
        AddCompletionRoutineView(addingExercises: .constant(.init()))
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
//            .environmentObject(TimerManager())
            .environmentObject(NavigationObject())
    }
}

#Preview { @MainActor in
    AddCompletionRoutineScreen()
}

