//
//  WatchToiOS.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import Foundation
import WatchConnectivity

class WatchToiOS: NSObject, ObservableObject {
    @Published var startStatus: Bool?

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendMessage(heartRate: [String:Any]) {
        let session = WCSession.default
        session.sendMessage(["heartRate":heartRate]) { _ in
            
        } errorHandler: { error in
            print(error)
        }

    }
}

extension WatchToiOS: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print("여기스")
    }
    
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("Watch: WCSession activated successfully")
        case .inactive:
            print("Watch: Unable to activate the WCSession. Error: \(error?.localizedDescription ?? "--")")
        case .notActivated:
            print("Watch: Unexpected .notActivated state received after trying to activate the WCSession")
        @unknown default:
            print("Watch: Unexpected state received after trying to activate the WCSession")
        }
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let startValue = message["start"] {
            // "start" 키의 값이 존재함
            // startValue를 사용하여 작업을 수행하면 됨
            print("값이 왔다")
            startStatus = startValue as? Bool
        } else {
            print("존재하지 않는 값")
        }
    }

    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
    }
    
    
}
