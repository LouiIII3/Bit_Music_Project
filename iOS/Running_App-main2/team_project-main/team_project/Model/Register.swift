//
//  LoginViewModel.swift
//  team_project
//
//  Created by Taewon Yoon on 4/4/24.
//

import Foundation

@Observable
class Register: Identifiable {
    let id = UUID()
    var nickname: String = ""
    var name: String = ""
    var password: String = ""
    var email: String = ""
    var verifiedCode: String = ""
}
