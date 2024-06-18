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
//    @EnvironmentObject private var timer: TimerManager
    @Environment(TimerManager.self) var timer
    @State var part: ExercisePart?
    @State var tool: ExerciseTool?
    @State var textfield: String = ""
    @State private var selectedExercises: [ExerciseDefaultModel] = []

    var exercise: ExerciseRoutineContainer? // 값이 없으면 처음 루틴 추가하는 것, 있으면 기존 있던 루틴에 운동 추가하는 것

    //MARK: FUNC

    // 만약 루틴에 추가한다면 exercise에 데이터가 있다면 추가한 루틴은 없어야한다.
    var body: some View {
        ZStack {
            
//            Color.backgroundColor1.ignoresSafeArea()
            
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
                            if let existExercise = exercise {
                                AddCompletionRoutineView(addingExercises: $selectedExercises, exercise: existExercise)
                            } else {
                                AddCompletionRoutineView(addingExercises: $selectedExercises)
                            }
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
            .overlay {
                if timer.showAlert {
                    // 커스텀 알림창 뷰입니다. alert 상태가 true일 때만 보여집니다.
                    ExerciseAlertView()
                }
        }
        }
    }
}

#Preview { @MainActor in
    NavigationStack {
        AddingRoutineView(part: .chest, tool: .machine, textfield: "")
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .environment(TimerManager())
            .environmentObject(NavigationObject())
    }
}
