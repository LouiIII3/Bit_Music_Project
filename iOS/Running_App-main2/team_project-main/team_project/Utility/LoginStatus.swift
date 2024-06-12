//
//  LoginStatus.swift
//  team_project
//
//  Created by Taewon Yoon on 11/17/23.
//

import Foundation

class LoginStatus: ObservableObject {
    @Published var isLogged = false
    
    @MainActor func checklogged(logged: Bool) {
        isLogged = logged
    }
    
}
