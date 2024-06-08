//
//  RoutineRecordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI
import SwiftData

struct RoutineRecordView: View {
    
    @EnvironmentObject var timer: TimerManager
    @Environment(\.modelContext) private var modelContext

    @Bindable var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터

    // 키보드를 내리는 함수
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    // 데이터를 가져오는데 selectedExercise에 해당하는 루틴의 기록을 가져와야 한다.
    
    var body: some View {
        VStack {
            HStack {
                Text(selectedExercise.exerciseName)//.exerciseName)
                    .font(.title)
                    .bold()
                
                Spacer()
            } //HSTACK
            .padding()
            
            HStack {
                VStack {
                    HStack(alignment: .top, spacing: 0) {
                        VStack {
                            Text("세트")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(1..<selectedExercise.set+1, id: \.self) { set in
                                Text(String(set))
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                            }
                        } //HSTACK
                        
                        VStack {
                            Text("KG")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
                                TextField("\(kg)", value: $selectedExercise.kg[index], formatter: NumberFormatter())
//                                TextField("\(kg)", text: $kg[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
//                                        saveRecord(kg: self.kg)
                                    }
                                    .onChange(of: selectedExercise.kg) { oldValue, newValue in
                                        print("변화했다 응애:\(oldValue) -> \(newValue)")
                                    }
                            }
                        } //VSTACK
//                        Array(data.enumerated())
                        VStack {
                            Text("횟수")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                                TextField("\(count)", value: $selectedExercise.count[index], formatter: NumberFormatter())
//                                TextField("\(count)", text: $count[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                                    .onSubmit {
//                                        saveRecord(count: self.count)
                                    }
                            }
                        } //VSTACK
                        
                        VStack {
                            Text("완료")
                                .frame(minWidth: 50, alignment: .center)
                            ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                                Button(action: {
                                    // `selectedExercise.done` 배열의 `index`에 해당하는 값을 toggle 처리
                                    selectedExercise.done[index].toggle()
//                                    saveRecord(done: self.done)
                                }, label: {
                                    Image(systemName: selectedExercise.done[index] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(selectedExercise.done[index]
                                                         ? .green : .gray)
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                })
                            }
                        } //VSTACK
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                Spacer()
            }
            Spacer()
            
            if timer.timerOn {
                if let data = timer.exerciseRoutineContainer {
                    TimerView(exerciseContainer: data)
                }
            }
        } //VSTACK
        .onTapGesture {
            hideKeyboard()
        }

    }
    
}
    

struct RoutineRecordScreen: View {
    
    @Query private var routineContainer: [ExerciseRoutineContainer]
    
    var body: some View {
        RoutineRecordView(selectedExercise: ExerciseDefaultModel(exerciseName: "백익스텐션", part: [.abs, .wholeBody], tool: .bodyWeight))//, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])
        
//        RoutineRecordView(selectedExercise: SampleData.exerciseDefaultModel.first!, set: 5, count: [0,0,0,0,0].map({ num in
//            return String(num)
//        }), kg: [0,0,0,0,0].map({ num in
//            return String(num)
//        }), done: [false,false,false,false,false])
    }
}

#Preview { @MainActor in
    RoutineRecordScreen()
        .modelContainer(previewRoutineContainer)
        .environmentObject(TimerManager())
}
