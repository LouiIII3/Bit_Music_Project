//
//  HTTPSignInClient.swift
//  CurrentMovie
//
//  Created by Taewon Yoon on 2023/07/09.
//

import Foundation
import UserNotifications
import UIKit
import SwiftUI
import JWTDecode



//MARK: 에러 다루는 곳
enum NetworkError: Error {
    case badRequest
    case serverError(String)
    case decodingError
    case invalidResponse
    case noData
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform request", comment: "badRequestError")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "serverError")
            case .decodingError:
                return NSLocalizedString("Unable to decode successfully.", comment: "decodingError")
            case .invalidResponse:
                return NSLocalizedString("Invalid response", comment: "invalidResponse")
        case .noData:
            return NSLocalizedString("No Data", comment: "NoData")
        }
    }
    
}
//MARK: HTTPMethod
enum HTTPMethod {
    case getnothing
    case get([URLQueryItem])
    case post(Data?)
    case delete(Data?)
    
    var name: String {
        switch self {
        case .get, .getnothing:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}
//MARK: 가져올 리소스 형태를 만듬
struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([]) // 열거형 get을 사용한다.
    var modelType: T.Type // 가져올 데이터의 타입
}


struct HTTPClient {
//    @AppStorage("token") var token = ""

    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
            case .getnothing:
            let components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false) // URL을 구성하는 구조
                guard let url = components?.url else {
                        throw NetworkError.badRequest
                }
                print(url)
            
                request = URLRequest(url: url)
                break
            
            case .get(let queryItems): //
            
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false) // URL을 구성하는 구조
                components?.queryItems = queryItems // http://127.0.0.1:8080/...?queryItems=\(queryItems값)이다.
                guard let url = components?.url else {
                        throw NetworkError.badRequest
                }
                print(url)
            
                request = URLRequest(url: url)
                
            case .post(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
            
            case .delete(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        do {
            let token = try KeyChain.get()
            
//            print("가져온 토큰값\(token.token)")
//            let decoded = try decode(jwt: token)
            configuration.httpAdditionalHeaders = ["Authorization": token.token]
//            }
            print("토큰 설정 완료")
        } catch {
            print("httpclient에서 token 가져오는데 에러:\(error.localizedDescription)")
        }
        let session = URLSession(configuration: configuration)
        print(session.configuration)
        let (data, _) = try await session.data(for: request)
        
//        guard let httpResponse = response as? HTTPURLResponse else {
//                throw NetworkError.invalidResponse
//        }
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch let decodingError as DecodingError {
            print("디코딩이 안되는데")
            // 디코딩 에러 처리
            switch decodingError {
            case .dataCorrupted(let context):
                print("Data Corrupted: \(context)")
            case .keyNotFound(let key, let context):
                print("Key Not Found: \(key), Context: \(context)")
            case .typeMismatch(let type, let context):
                print("Type Mismatch: \(type), Context: \(context)")
            case .valueNotFound(let type, let context):
                print("Value Not Found: \(type), Context: \(context)")
            @unknown default:
                print("Unknown Decoding Error")
            }
            throw NetworkError.decodingError
        } catch {
            print("Unexpected Error: \(error)")
            throw NetworkError.decodingError
        }

        
//        print("보낼 전체: \(request.description)")
        
        // decode한 값을 반환한다.
    }
    

    
}
