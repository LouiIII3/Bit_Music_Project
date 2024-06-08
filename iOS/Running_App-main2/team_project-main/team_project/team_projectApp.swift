//
//  team_projectApp.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI
import CoreData
import SwiftData

@main

struct team_projectApp: App {
    var loginmodel = LoginViewModel()
    @StateObject var isLogged = LoginStatus()
    @State var register = Register()
    @State var timerManager2 = TimerManager()
    @State private var path = NavigationObject()
    @State private var isSplashScreenVisible = true
    @Environment(\.scenePhase) var scenePhase
    @StateObject var musicPlayer = MusicPlayer(iosToWatch: iOSToWatch())
    
    
    
    // MARK: - FUNCTIOINS
    func MainTainSession(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.async {
            do {
                KeyChain.CheckToken { result in
                    switch result {
                    case .success(true): // 토큰이 있다면 재로그인을 한다
                        loginmodel.relogin { result in
                            if result {
                                print("재로그인성공")
                                self.isLogged.isLogged = true // 재로그인 성공했을 때
                                completion(true)
                            } else {
                                print("재로그인실패")
                                self.isLogged.isLogged = false // 토큰이 만료돼서 성공 못했을 때
                                completion(false)
                            }
                        }
                    case .success:
                        self.isLogged.isLogged = true
                        completion(true)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(false)
                    }
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    
    
//    var body: some Scene {
//        WindowGroup {
//            
//            ContentView()
//                .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self, MusicModel.self])//, ExerciseRecordModel.self], isAutosaveEnabled: false)
//                .environmentObject(musicPlayer) // 3월19일날 추가한거
//                .environment(timerManager2)
//                .environment(path)
//            
//        }
        
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                if !isSplashScreenVisible {
                    if isLogged.isLogged {
                        ContentView()
                    } else { // 만일 로그인이 실패한 상태라면
                        LoginView()
                    }
                } else {
                    EmptyView()
                }
            }
            
            .task {
                MainTainSession { result in
                    if result {
                        isSplashScreenVisible = false
                    } else {
                        isSplashScreenVisible = true
                    }
                }
            }
        }
        .environmentObject(isLogged)
        .modelContainer(for: [ExerciseRoutineContainer.self, ExerciseDefaultModel.self,  ExerciseRecordContainer.self, MusicModel.self])
        .environment(timerManager2)        
        .environmentObject(musicPlayer)
        .environment(path)
        .environment(register)
//        .onChange(of: scenePhase) {
//                do {
//                    try KeyChain.delete()
//                } catch {
//                    print("키체인 지우기 실패")
//                }
//        }
    }
}
