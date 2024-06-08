//
//  JWT.swift
//  team_project
//
//  Created by Taewon Yoon on 11/13/23.
//

import Foundation
import JWTDecode

class JWT {
//    var jwt: String?
//    var header: String?
//    var payload: String?
//    var signature: String?
    

    func isAvailable() -> Bool {
        print("키체인에 저장된 토큰 업데이트 여부")
        do {
            let credentials = try KeyChain.get() // KeyChain에서 토큰 가져오기
            let decoded = try decode(jwt: credentials.token) // 만약 만료됐다면 다시 로그인해서 가져와야한다
            if decoded.expired { // 토큰이 만료되었다면 다시 로그인을 시도합니다
                return false
            } else {
                return true
            }
        } catch {
            print("토큰 업데이트 여부 에러:\(error.localizedDescription)")
            return false
        }
    }
    
    func decode_header(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[0]) ?? [:]
    }
    
    func decode_payload(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[1]) ?? [:]
    }
    
    func decode_signature(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[2]) ?? [:]
    }

    func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    func decodeJWTPart(_ value: String) -> [String: Any]? {
      guard let bodyData = base64UrlDecode(value),
        let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
          return nil
      }

      return payload
    }

}
