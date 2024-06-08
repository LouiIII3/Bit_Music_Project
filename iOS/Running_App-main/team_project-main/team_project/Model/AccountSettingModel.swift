//
//  AccountSettingModel.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import Foundation

struct AccountSettingModel {
    let httpClient = HTTPClient()
    
    func changePassWord(userid: String, originPassword: String, newPassword: String) async -> RegisterResponseDTD {
        let passwordData = ["username": userid, "currentPassword":originPassword,"newPassword": newPassword, "confirmPassword":newPassword]
        do {
            let request = Resource(url: Constants().changePasswordPath!, method: .post(try JSONEncoder().encode(passwordData)), modelType: RegisterResponseDTD.self)
            return try await httpClient.load(request)
        } catch {
            print("에러 \(error)")
            return RegisterResponseDTD(error: true, reason: error.localizedDescription)
        }
    }
}

/*
 {
     "username": "사용자이름",
     "currentPassword": "password2",
     "newPassword": "password32",
     "confirmPassword": "password32"
 }
 */
