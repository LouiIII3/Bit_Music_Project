//
//  team_project_wApp.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI

@main
struct team_project_w_Watch_AppApp: App {
    @StateObject private var connectManager = WatchToiOS()
    @StateObject private var workoutManager = WorkoutManager.shared
    @State var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                
                ContentView(path: $path)
                    .sheet(isPresented: $workoutManager.showingSummaryView) {
                        SummaryView(path: $path)
                    }
                
                //            SessionPagingView()
                //            SelectingView()
                //                .environmentObject(connectManager)
                //                .environmentObject(workoutManager)
            }
        }
        .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])
        .environmentObject(connectManager)
        .environmentObject(workoutManager)
        
    }
}
