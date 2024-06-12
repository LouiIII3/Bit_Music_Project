//
//  Session.swift
//  team_project
//
//  Created by Taewon Yoon on 3/7/24.
//

import Foundation
//import SwiftUI
//
//struct Session {
//    var loginmodel = LoginModel()
//    @StateObject var isLogged = LoginStatus()    
//    
//    // 비동기로 자동 로그인 시도
//    func MainTainSession() {
//        do {
//            if try KeyChain.CheckToken() { // 토큰이 존재하는데 유효하지 않는다면
//                loginmodel.Relogin { result in
//                    if result {
//                        isLogged.isLogged = true
//                    } else {
//                        isLogged.isLogged = false
//                    }
//                }
//            } else { // 토큰이 존재하는데 유효한다면
//                // 바로 메인 화면으로 넘어가기
//                isLogged.isLogged = true
//            }
//        } catch KeychainError.notFound {
//            isLogged.isLogged = false
//        } catch {
//            print(error)
//            isLogged.isLogged = false
//        }
//    }
//}
