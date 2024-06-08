//
//  RoutineRecordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI
import SwiftData
//import YouTubePlayerKit

struct RoutineRecordView: View {
    
//    @EnvironmentObject var timer: TimerManager
    @Environment(TimerManager.self) var timer
    @Environment(\.modelContext) private var modelContext
    @Bindable var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터
    //    @StateObject var youTubePlayer: YouTubePlayer = "https://www.youtube.com/watch?v=tIZppe-RB0g"
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
        
    var body: some View {
        ZStack {
            
//            Color.backgroundColor1.ignoresSafeArea()
            
            VStack {
                HStack {
                    Text(selectedExercise.exerciseName)//.exerciseName)
                        .font(.title)
                        .bold()
                    
                    Spacer()
                } //HSTACK
                .padding()
                
                //            YouTubePlayerView(self.youTubePlayer) { state in
                //                // Overlay ViewBuilder closure to place an overlay View
                //                // for the current `YouTubePlayer.State`
                //                switch state {
                //                case .idle:
                //                    ProgressView()
                //                case .ready:
                //                    EmptyView()
                //                case .error(let error):
                //                    Text(verbatim: "YouTube player couldn't be loaded")
                //                }
                //            }.padding(.bottom)
                
//                ScrollViewReader(content: { proxy in
                    
                    ScrollView {
                        
                        HStack {
                            VStack {
                                HStack(alignment: .top, spacing: 0) {
                                    
                                    Divider()
                                    
                                    VStack {
                                        Text("세트")
                                            .frame(minWidth: 50, alignment: .center)
                                            .padding()
                                        ForEach(0..<selectedExercise.set, id: \.self) { set in
                                            Divider()
                                            Text(String(set))
                                                .frame(minWidth: 50, minHeight: 50, alignment: .center)
                                        }
                                    } //HSTACK
//                                    .background(.backgroundColor2)
                                    

                                    Divider()
                                    
                                    VStack {
                                        Text("KG")
                                            .frame(minWidth: 50, alignment: .center)
                                            .padding()
                                        ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
                                            Divider()
                                            TextField("\(kg)", value: $selectedExercise.kg[index], formatter: NumberFormatter())
                                                .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                                .frame(maxWidth: 50,minHeight: 50, alignment: .center)
                                                .keyboardType(.numberPad)
                                        }
                                    } //VSTACK
//                                    .background(.backgroundColor2)
                                    
                                    Divider()
                                    
                                    VStack {
                                        Text("횟수")
                                            .frame(minWidth: 50, alignment: .center)
                                            .padding()
                                        ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                                            Divider()
                                            TextField("\(count)", value: $selectedExercise.count[index], formatter: NumberFormatter())
                                                .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                                                .frame(maxWidth: 50,minHeight: 50, alignment: .center)
                                                .keyboardType(.numberPad)
                                        }
                                    } //VSTACK
//                                    .background(.backgroundColor2)
                                    
                                    Divider()
                                    
                                    VStack {
                                        Text("완료")
                                            .frame(minWidth: 50, alignment: .center)
                                            .padding()
                                        ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                                            Divider()
                                            Button(action: {
                                                selectedExercise.done[index].toggle()
                                            }, label: {
                                                Image(systemName: selectedExercise.done[index] ? "checkmark.circle.fill" : "circle")
                                                    .foregroundStyle(selectedExercise.done[index] ? .green : .gray)
                                                    .frame(maxWidth: 50,minHeight: 50, alignment: .center)
                                            })
                                        }
                                    } //VSTACK
//                                    .background(.backgroundColor2)
                                    
                                    Divider()
                                                                        
                                } //HSTACK

                            } //VSTACK
                        } //HSTACK
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                    } //SCROLLVIEW
                    .scrollIndicators(.hidden)

//                }) //SCROLLVIEWREADER
                
                
                if timer.isStarted {
                    if let data = timer.exerciseRoutineContainer {
                        TimerView(exerciseContainer: data)
                    }
                }
                Spacer()
            } //VSTACK
            .overlay(alignment: .bottom, content: {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        if selectedExercise.set > 1 {
                            selectedExercise.done.removeLast()
                            selectedExercise.kg.removeLast()
                            selectedExercise.count.removeLast()
                            selectedExercise.set -= 1
                        }
                    }, label: {
                        Text("세트삭제")
                            .foregroundStyle(.white)
                        Image(systemName: "minus.square")
                            .foregroundStyle(.red)
                    })
                    .padding()
                    
                    Button(action: {
                        selectedExercise.done.append(false)
                        selectedExercise.kg.append(0)
                        selectedExercise.count.append(0)
                        selectedExercise.set += 1
                    }, label: {
                        HStack {
                            Text("세트추가")
                                .foregroundStyle(.white)
                            Image(systemName: "plus.app")
                                .foregroundStyle(.green)
                        }
                    })
                    .padding()
                    
                    Spacer()
                } //HSTACK
            })
            .onTapGesture {
                hideKeyboard()
        }
        }
        
    }
    
}


struct RoutineRecordScreen: View {
    
    @Query private var routineContainer: [ExerciseRoutineContainer]
    
    var body: some View {
        RoutineRecordView(selectedExercise: ExerciseDefaultModel(exerciseName: "백익스텐션", part: [.abs, .wholeBody], tool: .bodyWeight))
    }
}

#Preview { @MainActor in
    RoutineRecordScreen()
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .environment(TimerManager())
        .environmentObject(NavigationObject())
}
