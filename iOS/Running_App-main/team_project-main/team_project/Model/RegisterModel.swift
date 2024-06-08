//
//  RegisterModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import Alamofire

class RegisterModel: ObservableObject {
    
    
    @Published var nickname: String?
    @Published var name: String?
    @Published var password: String?
    @Published var email: String?
    @Published var verifiedCode: String?
    
    init(email: String? = nil, name: String? = nil, kickname: String? = nil) {
        self.email = email
        self.name = name
        self.nickname = kickname
    }
    
    
    func requestEmailCode(email: String, completion: @escaping (Bool) -> Void) {
        let registerData = ["email": email]
        var url = Constants().requestEmailCode?.absoluteString
        url = (url ?? "") + "?email=\(email)"
        print("요청한 이메일:\(email)")
        AF.request(URL(string: url!)!,
                   method: .post)
        .responseData { response in
            print(response.request?.url ?? "값없음")
            print(response.request?.url?.query())
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
    //       2000ytw@naver.com
    func verifyEmailCode(verifycode: String, completion: @escaping (Bool) -> Void) {
//        let code = ["email": email, "code": verifiedCode]
//        let registerData = ["email": email]
        var url = Constants().verifyEmailCode?.absoluteString
        url = (url ?? "") + "?email=\(email!)&code=" + verifycode
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
    
    func register(completion: @escaping (Bool) -> Void) {
        let data = ["username":name, "nickname":nickname, "password":password, "email":email]
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
    
    
}
