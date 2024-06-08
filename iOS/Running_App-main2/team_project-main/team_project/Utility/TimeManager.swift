//
//  TimeManager.swift
//  team_project
//
//  Created by Taewon Yoon on 3/22/24.
//
import SwiftUI
import Combine

@Observable
class TimerManager {
    
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
    
    
    // Set the initial time to 0 seconds
    var timeRemaining = 0
    
    // A boolean used to show an alert when the time runs out
    var showAlert = false
    
    var showTimer = false
    
    // A boolean used to pause the timer
    var isStarted = false
        
    // Publisher from Combine used for the timer
    var timer: AnyCancellable?
    
    // set hour
    var hour: Int = 0
    
    // set minute
    var minute: Int = 0
    
    // set second
    var second: Int = 0
    
    // saving exercise by using ExerciseRoutineContianer
    var exerciseRoutineContainer: ExerciseRoutineContainer?
    
    // exercise start date
    var startTime: Date?
    
    // exercise stop date
    var endTime: Date?
    
    
    func initalize() {
        if hour != 0 || minute != 0 || second != 0 {
            timeRemaining = (hour*3600) + (minute*60) + second
            startTimer()
        }
    }
    
    func startTimer() {
        isStarted = true
        showTimer = true
        
         timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { _ in
                self.timeRemaining += 1
        }
    }
    
    func prepareCanceling() {
        timer?.cancel()
        showAlert = true
        endTime = Date()
    }
    
    func cancelTimer() {
        isStarted = false
        showAlert = false
        showTimer = false
    }
    
    func pauseOrResumeTimer() {
        isStarted.toggle()
        if isStarted {
            startTimer()
        } else {
            timer?.cancel()
        }
    }
}
