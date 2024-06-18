//
//  TimerView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//

import SwiftUI

struct TimerView: View {
    @Environment(TimerManager.self) var timer
    @State var rotation: CGFloat = 0.0
    var exerciseContainer: ExerciseRoutineContainer

    var body: some View {
        
        VStack {
            Divider().background(.white)
            HStack {
                VStack {
                    HStack {
                        Text("\(timer.exerciseRoutineContainer?.routineName ?? "")")
                        Spacer()
                    }
                    HStack {
                        Text(timer.convertSecondsToReadableTime(timer.timeRemaining))
                        Spacer()
                    }
                }
                
                Spacer()
                
                Button(action: { // 타이머가 동작중이고 멈춘상대가 아니라면
                    timer.pauseOrResumeTimer()
                }, label: {
                    Image(systemName: timer.isStarted ? "pause.fill" : "play.fill")
                })
                .padding()
                
                Button {
                    timer.prepareCanceling()
                } label: {
                    Image(systemName: "stop.fill")
                }
                
                
                .padding()
                
                
                
            }
            .padding(.leading)
            .foregroundStyle(.color2)
        }
        
    }
}

struct TimerScreen: View {
    var body: some View {
        TimerView(exerciseContainer: PreviewData().previewExerciseRoutineContainer)
    }
}

#Preview { @MainActor in
    TimerScreen()
        .modelContainer(previewRoutineContainer)
}
