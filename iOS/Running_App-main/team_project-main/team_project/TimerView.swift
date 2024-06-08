//
//  TimerView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject var timer: TimerManager
    @State var rotation: CGFloat = 0.0
    var exerciseContainer: ExerciseRoutineContainer
    
    func recordSaveExercise() {
        
    }
    
    var body: some View {

            
            HStack {
                VStack {
                    HStack {
                        Text("\(timer.exerciseRoutineContainer?.routineName ?? "")")
                        Spacer()
                    }
                    HStack {
                        Text("\(timer.elapsedTime2)")
                        Spacer()
                    }
                }
                
                
                Spacer()
                
                Button(action: { // 타이머가 동작중이고 멈춘상대가 아니라면
                    timer.timerOn && !timer.paused ? timer.pause() : timer.resume()
                }, label: {
                    Image(systemName: timer.timerOn && !timer.paused ? "pause.fill" : "play.fill")
                })
                .padding()
                
                Button {
                    timer.stop()
                    print(timer.stopped)
                } label: {
                    Image(systemName: "stop.fill")
                }
                
                
                .padding()
                
                
                
            }
            .padding()
            .foregroundStyle(.color1)
            

    }
}

#Preview {
    TimerView(exerciseContainer: PreviewData().previewExerciseRoutineContainer)
        .modelContainer(PreviewContainer.container)

        .environmentObject(TimerManager())
}
