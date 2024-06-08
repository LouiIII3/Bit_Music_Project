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
    @State private var path = NavigationObject()
    @State private var isSplashScreenVisible = true
    @Environment(\.scenePhase) var scenePhase
    @StateObject var musicPlayer = MusicPlayer(iosToWatch: iOSToWatch())
//    @StateObject var iosToWatch = iOSToWatch()
    
    
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
                .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])//, ExerciseRecordModel.self], isAutosaveEnabled: false)
                .environmentObject(musicPlayer) // 3월19일날 추가한거
                .environmentObject(timeManager)
                .environmentObject(iOSToWatch())
                .environment(path)
            

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
//        .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self])//, ExerciseRecordModel.self], isAutosaveEnabled: false)
//        .environmentObject(musicPlayer) // 3월19일날 추가한거
//        .environmentObject(timeManager)
////        .environmentObject(iosToWatch)
//        .environmentObject(register)
//
//        .environment(path)
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

