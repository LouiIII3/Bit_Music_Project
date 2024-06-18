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
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        //        let decoded = JSONDecoder().decode(, from: )
        print("데이터 타입으로 왔다")
    }
    
    @MainActor
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            
            if let heartRateDict = message["heartRate"] as? [String: Int] {
                self.bpm = heartRateDict["heartRate"]
                print("애플워치로 받은 심박수:\(String(describing: self.bpm?.description))")
            } else {
                print("심박수 값을 찾을 수 없습니다.")
            }
        }
    }
}
