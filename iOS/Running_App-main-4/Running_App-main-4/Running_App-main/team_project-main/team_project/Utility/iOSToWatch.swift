//
//  iOSToWatch.swift
//  team_project
//
//  Created by Taewon Yoon on 3/15/24.
//

import Foundation
import WatchConnectivity

class iOSToWatch: NSObject, ObservableObject {
    
    @Published var startStatus: Bool?
    @Published var bpm: Int?
    @Published var bpm2: String?
    @Published var bpm3: Double?
    @Published var update: Bool = false
    var number = 0
    
    let session = WCSession.default
    
    override init() {
        print("실행중")
        super.init()
        if WCSession.isSupported() {
            print("시작")
            let session = WCSession.default
            session.delegate = self
            session.activate()
            print("페어링 여부:\(session.isPaired)")
            print("애플워치 앱 설치 여부:\(session.isComplicationEnabled)")
        }
    }
    
    func check() {
        let session = WCSession.default
        print("페어링 여부:\(session.isPaired)")
    }
    
    func sendMessage(message: [String:Any]) {
        session.sendMessage(message) { heartRate in
            DispatchQueue.main.async {
                self.bpm = heartRate["heartRate"] as? Int ?? 0
            }
        } errorHandler: { error in
            print(error)
        }
        
    }
}

extension iOSToWatch: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("세션이 활성화되었다")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("세션이 비활성화되었다")
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("WCSession activated successfully")
        case .inactive:
            print("Unable to activate the WCSession. Error: \(error?.localizedDescription ?? "--")")
        case .notActivated:
            print("Unexpected .notActivated state received after trying to activate the WCSession")
        @unknown default:
            print("Unexpected state received after trying to activate the WCSession")
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let startValue = message["heartRate"] {
            // "start" 키의 값이 존재함
            // startValue를 사용하여 작업을 수행하면 됨
            print("값이 왔다:\(startValue)")
        } else {
            print("존재하지 않는 값")
        }
    }
    
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        //        let decoded = JSONDecoder().decode(, from: )
        print("데이터 타입으로 왔다")
    }
    
    @MainActor
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            for (key, _) in message {
                if key == "heartRate" {
                    self.bpm = message[key] as? Int
                    print("심박수:\(self.bpm)")
                } else if key == "update" {
                    // 다시 fetch해오기
                    self.update = true
                    print("업데이트 요청 받았다")
                }
            }
//            if let heartRateDict = message["heartRate"] as? [String: Int] {
//                let numbers = heartRateDict
//                print("number는?:\(numbers)")
//                let a = heartRateDict["heartRate"]
//                print(a ?? 00000)
//                self.bpm = a
//                print(self.bpm ?? 99999)
//            } else {
//                print("심박수 값을 찾을 수 없습니다.")
//            }
        }
    }
    
    
    
}
