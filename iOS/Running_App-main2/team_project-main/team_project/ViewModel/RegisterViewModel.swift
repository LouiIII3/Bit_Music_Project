//
//  RegisterModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import Alamofire
import SwiftUI

class RegisterViewModel {
    @Environment(Register.self) var register
    
    func changeRequestEmailCode(email: String, completion: @escaping (Bool) -> Void) {
//        let registerData = ["email": email]
        var url = Constants().cmailConfirm2?.absoluteString
        url = (url ?? "") + "?email=\(email)"
        print("요청한 이메일:\(email) + \(url ?? "")")
        AF.request(URL(string: url!)!,
                   method: .post)
        .responseData { response in
            switch response.result {
            case .success:
                print("성공")
                return completion(true)
            case .failure:
                print(response.error.debugDescription)
                return completion(false)
            }
        }
    }
    
    
    func requestEmailCode(email: String, completion: @escaping (Bool) -> Void) {
//        let registerData = ["email": email]
        var url = Constants().requestEmailCode?.absoluteString
        url = (url ?? "") + "?email=\(email)"
        print("요청한 이메일:\(email)")
        AF.request(URL(string: url!)!,
                   method: .post)
        .responseData { response in
            switch response.result {
            case .success:
                print("성공")
                return completion(true)
            case .failure:
                print(response.error.debugDescription)
                return completion(false)
            }
        }
    }
    //       
    func verifyEmailCode(verifycode: String, completion: @escaping (Bool) -> Void) {
        var url = Constants().verifyEmailCode?.absoluteString
        url = (url ?? "") + "?email=\(register.email)&code=" + verifycode
        print(url!)
        AF.request(URL(string: url!)!,
                   method: .post)
        .responseString { response in
            switch response.result {
            case .success:
                print("성공")
                return completion(true)
            case .failure:
                print(response.error.debugDescription)
                return completion(false)
            }
        }
    }
    //
    func register(completion: @escaping (Bool) -> Void) {
        let data = ["username":register.name, "nickname":register.nickname, "password":register.password, "email":register.email]
        AF.request(Constants().registerPath!
                   ,method: .post,
        parameters: data,
                   encoder: JSONParameterEncoder.default).response { response in
            switch response.result {
            case .success:
                print("성공")
                return completion(true)
            case .failure:
                print(response.error.debugDescription)
                return completion(false)
            }
        }
    }
    
    
    func changePassword(verifyCode: String, userid: String, password: String, completion: @escaping (Bool) -> Void) {
        let data = ["email":userid, "newPassword":password]
        var url = Constants().changePassword2?.absoluteString
        url = (url ?? "") + "?email=\(register.email)" + "&code=\(verifyCode)" + "&newPassword=\(password)"
        print(url!)
        AF.request(url!,
                   method: .post,
        parameters: data,
                   encoder: JSONParameterEncoder.default).responseString(completionHandler: { response in
            switch response.result {
            case .success:
                print(response)
                print("비밀번호 재설정 설공")
                return completion(true)
            case .failure:
                print(response.error.debugDescription)
                return completion(false)
            }
        })
                                                                         
    }
    
}
