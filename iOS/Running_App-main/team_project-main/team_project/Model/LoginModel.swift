import Foundation
import JWTDecode
import SwiftUI
import Alamofire

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

class LoginModel {
    
    
//    @EnvironmentObject var isLogged: LoginStatus
    //MARK: 로그인 (토큰처음부터 없었을때)
    func login2(username: String, password: String, completion: @escaping (Bool) -> Void) {
        AF.upload(
            multipartFormData: { multipartFormData in
                if let usernameData = username.data(using: .utf8),
                   let passwordData = password.data(using: .utf8) {
                    multipartFormData.append(usernameData, withName: "username")
                    multipartFormData.append(passwordData, withName: "password")
                }
            },
            to: Constants().loginPath!,
            method: .post,
            headers: ["Content-Type": "multipart/form-data"]
        ).responseString { response in
            if let httpResponse = response.response {
                if let token = httpResponse.allHeaderFields["Authorization"] as? String {
                    print("받은 토큰:\(token)")
                    let tokenWithoutBearer = token.replacingOccurrences(of: "Bearer ", with: "")
                    print("바꾼 토큰:\(tokenWithoutBearer)")
                    let credentials = Credentials(username: username, psssword: password, token: tokenWithoutBearer)
                    do {
                        try KeyChain.save(credentials: credentials)
                        return completion(true)
                    } catch {
                        return completion(false)
                    }
                }
            }
        }

    }
    
    //MARK: 재로그인
    func Relogin2(completion: @escaping (Bool) -> Void) {
        do {
            let credentials = try KeyChain.get()
            login2(username: credentials.username, password: credentials.psssword) { result in
                print("재로그인 실패: \(result)")
                return completion(result)
            }
        } catch {
            return completion(false)
        }
    }
    

    
}

struct something: Codable {
    var key1: String?
}

struct somethingDTO: Codable {
    var error: String?
}

struct RegisterResponseDTO: Codable {
    var error: Bool
    var reason: String?
}

