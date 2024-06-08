//
//  SplashScreenView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/17/23.
//
import SwiftUI
import JWTDecode
import Foundation
import AVFAudio

struct SplashScreenView: View {
    // MARK: - PROPERTIES
    @State private var isLoggedIn: Bool = false
    @State private var credentials: Credentials?
    @State private var token: String?
    @EnvironmentObject var isLogged: LoginStatus
    let loginmodel = LoginModel()
    
    // MARK: - FUNCTIONS
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
    
    // MARK: - BODY
    
    var body: some View {
        
        NavigationStack {
            // Splash 화면 디자인
            Text("Your App Splash Screen")
                .onAppear { // Splash 화면에서 비동기 작업 수행
                    Task { // 토큰 만료 여부 확인 후 만료되었으면 자동 로그인 진행
                        MainTainSession()
                        

                        
                    }
                }
        }
    }
    
    
}

#Preview {
    SplashScreenView()
}
