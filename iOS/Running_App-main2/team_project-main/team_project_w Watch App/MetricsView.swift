//
//  CurrentStatusView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import HealthKit

struct MetricsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    @EnvironmentObject var connect: WatchToiOS
    @State private var heartScale: Bool = false
    
    func heart(num: Double) -> String {
        if num <= 90 {
            return "slow"
        } else if num <= 110 {
            return "normal"
        } else {
            return "fast"
        }
    }
    
    var body: some View {
        
        
        TimelineView(MetricsTimelineSchedule(from: workoutManager.builder?.startDate ?? Date(),
                                             isPaused: workoutManager.session?.state == .paused)) { context in
            VStack(alignment: .leading) {
                ElapsedTimeView(elapsedTime: workoutManager.builder?.elapsedTime(at: context.date) ?? 0, showSubseconds: context.cadence == .live)
                    .foregroundStyle(.yellow)
                Text(Measurement(value: workoutManager.activeEnergy, unit: UnitEnergy.kilocalories)
                    .formatted(.measurement(width: .abbreviated, usage: .workout, numberFormatStyle: .number.precision(.fractionLength(0)))))
                
                
                HStack {
                    Text(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))) + " bpm")
                        .minimumScaleFactor(0.5) // 텍스트를 최소 50%까지 축소

                    Spacer()
                    Text(heart(num: workoutManager.heartRate))
                        .font(.callout)
                    
                        
                }
                
                
                
                //                Text(Measurement(value: workoutManager.distance, unit: UnitLength.meters).formatted(.measurement(width: .abbreviated, usage: .road)))
            }
            .font(.system(.title, design: .rounded).monospacedDigit().lowercaseSmallCaps())
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            
        }
                                             .onAppear {
                                                 withAnimation(.easeInOut(duration: 0.8).repeatForever()) {
                                                     heartScale.toggle()
                                                 }
                                             }
        
        
        
    }
}

#Preview {
    MetricsView().environmentObject(WorkoutManager())
}

private struct MetricsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    var isPaused: Bool
    
    init(from startDate: Date, isPaused: Bool) {
        self.startDate = startDate
        self.isPaused = isPaused
    }
    
    func entries(from startDate: Date, mode: TimelineScheduleMode) -> AnyIterator<Date> {
        var baseSchedule = PeriodicTimelineSchedule(from: self.startDate,
                                                    by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0))
            .entries(from: startDate, mode: mode)
        
        return AnyIterator<Date> {
            guard !isPaused else { return nil }
            return baseSchedule.next()
        }
    }
}
