//
//  SessionPagingView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import HealthKit
import WatchKit

struct SessionPagingView: View {
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    var exerciseRoutineContainer: ExerciseRoutineContainer

    @State private var animation: Animation?
    @State private var heartScale: Bool = false
    @State private var startTimer: Bool = false

    @State var id = UUID()
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        
        ZStack {
            
            if !startTimer {
                StartingTimerView(finished: $startTimer)
            } else {
                TabView(selection: $selection, content:  {
                    ControlView(exerciseContainer: exerciseRoutineContainer).tag(Tab.controls)
                    
                    TabView {
                        MetricsView().tag(Tab.metrics).padding(.top)
                        RoutineListViewWatch(exerciseContainer: exerciseRoutineContainer)
                            .containerBackground(.red.gradient, for: .navigation)
                    }.tabViewStyle(.carousel).tag(Tab.metrics)
                    
                    NowPlayingView().tag(Tab.nowPlaying)
                })
                
                .navigationBarBackButtonHidden(true)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
                .onChange(of: isLuminanceReduced) {
                    displayMetricsView()
                }
                .containerBackground(.blue.gradient, for: .navigation)

                .onAppear {
                    workoutManager.selectedWorkout = .traditionalStrengthTraining
                }
            } //ELSE
        } //ZSTACK
        .animation(.spring, value: startTimer)

    }
    
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
    
}

struct SessionPagingScreen: View {
    
    var body: some View {
        SessionPagingView(exerciseRoutineContainer: SampleData.routineContainer.first!)
    }
}

#Preview { @MainActor in
    NavigationStack {
        SessionPagingScreen()
            .environmentObject(WorkoutManager())
            .environmentObject(WatchToiOS())
            .modelContainer(previewRoutineContainer)
    }
}

/*
 .onChange(of: workoutManager.heartRate) { oldValue, newValue in
     if newValue < 80 {
         withAnimation(Animation.linear.speed(0.5).repeatForever()) {
             heartScale.toggle()
         }
     } else if newValue < 100 {
         withAnimation(Animation.linear.speed(0.65).repeatForever()) {
             heartScale.toggle()
         }
     } else if newValue < 120 {
         withAnimation(Animation.linear.speed(0.8).repeatForever()) {
             heartScale.toggle()
         }
     } else if newValue < 140 {
         withAnimation(Animation.linear.speed(0.95).repeatForever()) {
             heartScale.toggle()
         }
     } else if newValue < 160 {
         withAnimation(Animation.linear.speed(1.05).repeatForever()) {
             heartScale.toggle()
         }
     } else if newValue < 180 {
         withAnimation(Animation.linear.speed(1.2).repeatForever()) {
             heartScale.toggle()
         }
     } else {
         withAnimation(Animation.linear.speed(1.3).repeatForever()) {
             heartScale.toggle()
         }
     }
 }
 */
