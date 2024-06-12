//
//  RecordInfoView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/24/24.
//

import SwiftUI

struct RecordInfoView: View {
    //    @EnvironmentObject var timer: TimerManager
    @Environment(TimerManager.self) var timer
    
    var selectedExercise: ExerciseRecordModel // 선택된 단독 데이터
    @State var set: Int
    @State var count: [String]
    @State var kg: [String]
    @State var done: [Bool]
    @State var infoHeight: CGFloat = 0.0
    
    init(selectedExercise: ExerciseRecordModel, set: Int, count: [Int], kg: [Int], done: [Bool]) {
        print("가져온 운동 이름:\(selectedExercise.exerciseName)")
        print("가져온 운동 횟수:\(selectedExercise.count)")
        print("가져온 운동 kg:\(selectedExercise.kg)")
        self.selectedExercise = selectedExercise
        self.set = set
        self.count = count.map({ count in
            return String(count)
        })
        self.kg = kg.map({ kg in
            return String(kg)
        })
        self.done = done
        
        print("기록뷰에 있는 세트:\(set)")
        print("기록뷰에 있는 횟수:\(count)")
        print("기록뷰에 있는 kg:\(kg)")
    }
    
    // 키보드를 내리는 함수
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    
    // 데이터를 가져오는데 selectedExercise에 해당하는 루틴의 기록을 가져와야 한다.
    
    var body: some View {
        ZStack {
            ScrollView {
                infoView
            }
        } //ZSTACK
        .onTapGesture {
            hideKeyboard()
        }
        .onChange(of: kg) { oldValue, newValue in
            selectedExercise.kg = kg.map({ kg in
                return Int(kg) ?? 999
            })
        }
        .onChange(of: count) { oldValue, newValue in
            print("count는 \(oldValue)에서 \(newValue)로 바뀜")
            selectedExercise.count = count.map({ count in
                return Int(count) ?? 999
            })
            print("저장된 count: \(selectedExercise.count.description)")
            
        }
        .onChange(of: done) { oldValue, newValue in
            selectedExercise.done = done
        }
        .onChange(of: set) { oldValue, newValue in
            selectedExercise.set = set
        }
    }
}

#Preview {
    RecordInfoView(selectedExercise: .init(exerciseName: "랫풀다운", part: [.back], tool: .machine, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false]), set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])
        .environment(TimerManager())
}

extension RecordInfoView {
    var infoView: some View {
        VStack {
            HStack {
                Text(selectedExercise.exerciseName)
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
                                .padding()
                            ForEach(1..<selectedExercise.set+1, id: \.self) { set in
                                Divider()
                                Text(String(set))
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                            }
                        } //HSTACK
//                        .background(.backgroundColor2)
                        
                        Divider()
                        
                        VStack {
                            Text("KG")
                                .frame(minWidth: 50, alignment: .center)
                                .padding()
                            ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
                                Divider()
                                TextField("0", text: $kg[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                            }
                        } //VSTACK
//                        .background(.backgroundColor2)
                        
                        Divider()
                        
                        VStack {
                            Text("횟수")
                                .frame(minWidth: 50, alignment: .center)
                                .padding()
                            ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                                Divider()
                                TextField("0", text: $count[index])
                                    .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                    .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                    .keyboardType(.numberPad)
                            }
                        } //VSTACK
//                        .background(.backgroundColor2)
                        
                        Divider()
                        
                        VStack {
                            Text("완료")
                                .frame(minWidth: 50, alignment: .center)
                                .padding()
                            ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                                Divider()
                                Button(action: {
                                    self.done[index].toggle()
                                }, label: {
                                    Image(systemName: self.done[index] ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(self.done[index]
                                                         ? .green : .gray)
                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                })
                                
                            }
                        } //VSTACK
//                        .background(.backgroundColor2)
                        Divider()
                    } //HSTACK
                } //VSTACK
            } //HSTACK
            
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
            
            if timer.isStarted {
                if let data = timer.exerciseRoutineContainer {
                    TimerView(exerciseContainer: data)
                }
            }
            Spacer()
        } //VSTACK
    }
}
//
//struct RecordCheckListView: View {
//    var selectedExercise: ExerciseRecordModel // 선택된 단독 데이터
//    @State var set: Int
//    @State var count: [String]
//    @State var kg: [String]
//    @State var done: [Bool]
//    @State var infoHeight: CGFloat = 0.0
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text(selectedExercise.exerciseName)
//                    .font(.title)
//                    .bold()
//
//                Spacer()
//            } //HSTACK
//            .padding()
//
//                HStack {
//                    VStack {
//                        HStack(alignment: .top, spacing: 0) {
//                            VStack {
//                                Text("세트")
//                                    .frame(minWidth: 50, alignment: .center)
//                                    .padding()
//                                ForEach(0..<selectedExercise.set, id: \.self) { set in
//                                    Divider()
//                                    Text(String(set))
//                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
//                                }
//                            } //HSTACK
//                            .background(.backgroundColor2)
//
//
//                            VStack {
//                                Text("KG")
//                                    .frame(minWidth: 50, alignment: .center)
//                                    .padding()
//                                ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
//                                    Divider()
//                                    TextField("0", text: $kg[index])
//                                        .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
//                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
//                                        .keyboardType(.numberPad)
//                                }
//                            } //VSTACK
//                            .background(.backgroundColor2)
//
//
//                            VStack {
//                                Text("횟수")
//                                    .frame(minWidth: 50, alignment: .center)
//                                    .padding()
//                                ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
//                                    Divider()
//                                    TextField("0", text: $count[index])
//                                        .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
//                                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
//                                        .keyboardType(.numberPad)
//                                }
//                            } //VSTACK
//                            .background(.backgroundColor2)
//
//
//
//                            VStack {
//                                Text("완료")
//                                    .frame(minWidth: 50, alignment: .center)
//                                    .padding()
//                                ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
//                                    Divider()
//                                    Button(action: {
//                                        self.done[index].toggle()
//                                    }, label: {
//                                        Image(systemName: self.done[index] ? "checkmark.circle.fill" : "circle")
//                                            .foregroundStyle(self.done[index]
//                                                             ? .green : .gray)
//                                            .frame(minWidth: 50, minHeight: 50, alignment: .center)
//                                    })
//
//                                }
//
//                            } //VSTACK
//                            .background(.backgroundColor2)
//
//                        }
//
//                    }
//
//                }
//
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .padding()
//
//
//                if timer.isStarted {
//                    if let data = timer.exerciseRoutineContainer {
//                        TimerView(exerciseContainer: data)
//                    }
//                }
//
//            Spacer()
//        } //VSTACK
//    }
//}
