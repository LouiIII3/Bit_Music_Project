//
//  team_projectApp.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI
import CoreData
import AVFoundation
import SwiftData

@main

struct team_projectApp: App {
    var loginmodel = LoginModel()
    @StateObject var isLogged = LoginStatus()
    @StateObject var timeManager = TimerManager()
    @StateObject var register = RegisterModel()
    @State private var isSplashScreenVisible = true
//    @StateObject var connectManager = iOSToWatch()
    @Environment(\.scenePhase) var scenePhase
    @StateObject var musicPlayer = MusicPlayer()
    
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
    
    // MARK: - FUNCTIOINS
    func MainTainSession() {
        DispatchQueue.main.async {
            do {
                KeyChain.CheckToken { result in
                    switch result {
                    case .success(true):
                        loginmodel.Relogin2 { result in
                            if result {
                                self.isLogged.isLogged = true
                            } else {
                                self.isLogged.isLogged = false
                            }
                        }
                    case .success(false):
                        self.isLogged.isLogged = true
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    

    var body: some Scene {
        WindowGroup {

            ContentView()
//                .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])
                .modelContainer(sharedModelContainer)
                .environmentObject(musicPlayer) // 3월19일날 추가한거
                .environmentObject(timeManager)
                .environmentObject(register)

            }
        }
    
    
//    var body: some Scene {
//        WindowGroup {
//            ZStack {
//                if isSplashScreenVisible {
//                    SplashScreenView()
//                        .onAppear {
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                withAnimation {
//                                    isSplashScreenVisible = false
//                                }
//                            }
//                        }
//                } else {
//                    if isLogged.isLogged {
//                        ContentView()
//                    } else { // 만일 로그인이 실패한 상태라면
//                        LoginView()
//                    }
//                }
//            }
//        }
//        .environmentObject(isLogged)
//                        .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])
//                        .environmentObject(musicPlayer) // 3월19일날 추가한거
//                        .environmentObject(timeManager)
//                        .environmentObject(register)
//        .onChange(of: scenePhase) {
////                do {
////                    try KeyChain.delete()
////                } catch {
////                    print("키체인 지우기 실패")
////                }
//            MainTainSession()
//        }
//    }
}

