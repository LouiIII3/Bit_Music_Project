//
//  TimeManager.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//
import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var elapsedTime: TimeInterval = 0
    @Published var elapsedTime2: String = ""
    @Published var timerOn: Bool = false // 측정하고 있는중인지에 대한 여부
    @Published var stopped: Bool = false // 중단 버튼 눌렀는지에 대한 여부
    @Published var paused: Bool = false
    @Published var exerciseRoutineContainer: ExerciseRoutineContainer?
    
    
    var timer: Timer?
    var startTime: Date?
    var endTime: Date?
    var pauseStartTime: Date? // 일시정지 시작 시간
    var totalPauseDuration: TimeInterval = 0 // 누적된 일시정지 시간
    var routineName: String = ""
    

    
    func start() {
        print("시작")
        timerOn = true
        stopped = false
        startTime = Date()
        pauseStartTime = nil
        totalPauseDuration = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let strongSelf = self else { return }
            let currentTime = Date().timeIntervalSince(strongSelf.startTime!) - strongSelf.totalPauseDuration
            strongSelf.elapsedTime = currentTime
            strongSelf.elapsedTime2 = strongSelf.convertSecondsToReadableTime(Int(currentTime))
        }
    }
    
    func pause() {
        print("중단")
        paused = true
        pauseStartTime = Date() // 일시정지 시작 시간 기록
        timer?.invalidate()
    }
//    timer.timerOn && timer.stopped
    
    func resume() {
        paused = false
        stopped = false
        if let pauseStart = pauseStartTime {
            let pauseDuration = Date().timeIntervalSince(pauseStart)
            totalPauseDuration += pauseDuration // 일시정지 시간을 누적
        }
        pauseStartTime = nil // 일시정지 시작 시간 초기화
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let strongSelf = self else { return }
            let currentTime = Date().timeIntervalSince(strongSelf.startTime!) - strongSelf.totalPauseDuration
            strongSelf.elapsedTime = currentTime
            strongSelf.elapsedTime2 = strongSelf.convertSecondsToReadableTime(Int(currentTime))
        }
    }
    

    func stop() {
        print("종료")
        stopped = true
        pause()
        endTime = Date()
        pauseStartTime = Date() // 일시정지 시작 시간 기록
        timer?.invalidate()
    }
    
    func termination() {
        timerOn = false
    }
    
}

extension TimerManager {
    func convertSecondsToReadableTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        
        // 시간, 분, 초를 문자열로 조합
        var timeString = ""
        
        if hours > 0 {
            timeString += "\(hours)시간 "
        }
        
        if minutes > 0 || hours > 0 { // 시간이 있으면 분도 표시, 시간이 없더라도 분이 있으면 표시
            timeString += "\(minutes)분 "
        }
        
        if remainingSeconds > 0 || (hours == 0 && minutes == 0) { // 시간과 분이 모두 0이면 초만 표시
            timeString += "\(remainingSeconds)초"
        }
        
        return timeString.trimmingCharacters(in: .whitespaces)
    }
}
