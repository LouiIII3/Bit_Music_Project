//
//  LoginResponseDTO.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import Foundation

struct LoginResponseDTO: Codable {
    let token: String?
}

/*
 import Foundation

 // Base64로 인코딩된 문자열
 let base64String = "SGVsbG8gd29ybGQh"

 // Base64 디코딩
 if let data = Data(base64Encoded: base64String) {
     // 디코딩된 데이터를 문자열로 변환
     if let decodedString = String(data: data, encoding: .utf8) {
         print("Decoded String: \(decodedString)")
     } else {
         print("Failed to convert decoded data to string.")
     }
 } else {
     print("Failed to decode Base64 string.")
 }

 */
