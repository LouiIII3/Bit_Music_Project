//
//  WatchToiOS.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import Foundation
import WatchConnectivity
import SwiftUI

class WatchToiOS: NSObject, ObservableObject {
    @Published var startStatus: Bool?
//    @EnvironmentObject var workoutManager: WorkoutManager
    let workoutManager = WorkoutManager.shared
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func sendMessage(heartRate: [String:Int]) {
        let session = WCSession.default
        session.sendMessage(["heartRate":heartRate]) { _ in
            print("심박수 전송중")
        } errorHandler: { error in
            print("심박수 보내는데 에러:\(error)")
        }

    }
}

extension WatchToiOS: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
//        if let heartrate = message["heartRate"] {
//            print("심박수 요청")
//            replyHandler(["heartRate":workoutManager.heartRate])
//        } else {
//            print("이러면 안되자나")
//        }
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
        print("긴데")
       
    }

    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
    }
    
    
}
