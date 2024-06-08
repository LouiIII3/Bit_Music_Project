//
//  team_project_wApp.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import SwiftData

@main
struct team_project_w_Watch_AppApp: App {
    @StateObject private var connectManager = WatchToiOS()
    @StateObject private var workoutManager = WorkoutManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ExerciseRoutineContainer.self,
            ExerciseDefaultModel.self,
            ExerciseRecordContainer.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(sharedModelContainer)

//            SessionPagingView()
            
//            SelectingView()
//                .environmentObject(connectManager)
//                .environmentObject(workoutManager)
        }

    }
}
