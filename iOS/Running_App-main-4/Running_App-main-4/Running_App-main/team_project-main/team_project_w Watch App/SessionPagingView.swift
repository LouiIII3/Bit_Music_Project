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
//    @EnvironmentObject var connectManager: WatchToiOS
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var selection: Tab = .metrics
    var exerciseRoutineContainer: ExerciseRoutineContainer
    @Binding var path: NavigationPath
//    @Binding var workoutType: HKWorkoutActivityType
    
    enum Tab {
        case controls, metrics, nowPlaying
    }
    
    var body: some View {
        TabView(selection: $selection, content:  {
            ControlView(exerciseContainer: exerciseRoutineContainer).tag(Tab.controls)
            
            TabView {
                MetricsView().tag(Tab.metrics)
                RoutineListViewWatch(exerciseContainer: exerciseRoutineContainer)
            }.tabViewStyle(.carousel).tag(Tab.metrics)
            
            NowPlayingView().tag(Tab.nowPlaying)
        })
        .navigationBarBackButtonHidden()
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: isLuminanceReduced ? .never : .automatic))
        .onChange(of: isLuminanceReduced) {
            displayMetricsView()
        }
        .onAppear(perform: {
            workoutManager.startWorkout()
        })
    }
    
    private func displayMetricsView() {
        withAnimation {
            selection = .metrics
        }
    }
}

struct SessionPagingScreen: View {
    
    var body: some View {
        SessionPagingView(exerciseRoutineContainer: SampleData.routineContainer.first!, path: .constant(NavigationPath()))
    }
}

#Preview { @MainActor in
    SessionPagingScreen()
        .environmentObject(WorkoutManager())
        .modelContainer(previewRoutineContainer)
    
}
