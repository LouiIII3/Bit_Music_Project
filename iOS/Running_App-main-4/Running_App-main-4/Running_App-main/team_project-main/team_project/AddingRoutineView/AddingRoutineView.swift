//
//  AddingRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI
import SwiftData

struct AddingRoutineView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var dbContext
    @Environment(NavigationObject.self) private var path
    @State var part: ExercisePart?
    @State var tool: ExerciseTool?
    @State var textfield: String = ""
    @State private var selectedExercises: [ExerciseDefaultModel] = []

    var exercise: ExerciseRoutineContainer? // 만약에 기존에 있던 저장소에 추가하려면 존재 / 처음이라면 nil이 들어있을 것임

    //MARK: FUNC

//    func saveRoutine() {
//        // 만일 새로운 데이터라면
//        guard let existData = exercise else {
//            let newExerciseRoutineContainer = ExerciseRoutineContainer(routineName: "루틴1", exerciseDefaultModel: selectedExercises)
//            dbContext.insert(newExerciseRoutineContainer)
//            return
//        }
//        // 만약 기존에 존재했던 데이터라면 새로 선택한 것들을 넣는다
//        
//        let saveData = selectedExercises.filter { ExerciseDefaultModel in
//            !(existData.exerciseDefaultModel?.contains(where: { $0.exerciseName == ExerciseDefaultModel.exerciseName }) ?? false)
//        }
//        // 기존에 있던 데이터 + 새로 추가하는 데이터
//        let container = ExerciseRoutineContainer(routineName: "루틴1", exerciseDefaultModel: saveData + selectedExercises)
//        dbContext.insert(container)
//    }

    // 만약 루틴에 추가한다면 exercise에 데이터가 있다면 추가한 루틴은 없어야한다.
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                }).padding(.leading, 10)
                SearchBar(text: $textfield)
            }.padding(10)
            
            PartSearchMenuView(part: $part, selectedColor: .orange)
            ToolSearchMenuView(tool: $tool, selectedColor: .green)
            ExerciseListView(targetPart: $part, targetTool: $tool, selectedExercises: $selectedExercises, existedExercise: exercise)
                
            
        }
        .navigationBarBackButtonHidden()
        .onChange(of: selectedExercises) { oldValue, newValue in
            print("개수 변했다: \(newValue.count)")
        }
        .overlay {
            VStack {
                Spacer()
                HStack {
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .frame(width: 30, height: 33)
                    })
                    .padding()
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.red)
                    .foregroundStyle(Color.white)
                    
                    Spacer()
                    
                    
                    
                    NavigationLink {
                        // 데이터 저장하기
                        // 이미 존재했던 데이터가 있었다면 저장하고
                        // 새로운 데이터면 다시 확인할 수 있도록 만든다
                        if exercise != nil {
                            AddCompletionRoutineView(selectedExercises: $selectedExercises)
                        }
                        //                        dismiss()
                    } label: {
                        HStack {
                            if !selectedExercises.isEmpty {
                                Text("\(selectedExercises.count)")
                                    .font(.title)
                                    .bold()
                            }
                            Text("운동 추가")
                                .font(.title)
                                .bold()
                        }
                        .frame(width: 170, height: 33, alignment: .bottom)
                        
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.white)
                    .foregroundStyle(Color.red)
                    .opacity(selectedExercises.isEmpty ? 0 : 1)
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .frame(width: 30, height: 33)
                    })
                    .padding()
                    .buttonStyle(BorderedProminentButtonStyle())
                    .tint(.brown)
                    .foregroundStyle(Color.white)
                    .opacity(selectedExercises.isEmpty ? 0 : 1)
                    
                    
                    
                }
            } //VSTACK
        } //OVERLAY
    }
}

#Preview { @MainActor in
    AddingRoutineView(part: .chest, tool: .machine, textfield: "")
        .modelContainer(previewRoutineContainer)
}
