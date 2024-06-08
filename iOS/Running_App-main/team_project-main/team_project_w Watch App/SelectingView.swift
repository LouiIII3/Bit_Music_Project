//
//  SelectingView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import HealthKit

struct SelectingView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var workoutTypes: [HKWorkoutActivityType] = [.traditionalStrengthTraining, .running, .cycling]
    
    var body: some View {
        NavigationStack {
            List(workoutTypes, id: \.self, selection: $workoutManager.selectedWorkout) { workout in
                NavigationLink {
                    SessionPagingView().environmentObject(workoutManager)
                } label: {
                    Text(workout.name)
                }.padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                    .tag(workout)
                    
            }
            .listStyle(.carousel)
            .navigationTitle("운동 시작하기")
            .onAppear {
                workoutManager.requestAuthorization()
            }
        }
    }
}

#Preview {
    SelectingView()
        .environmentObject(WorkoutManager())
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self {
        case .traditionalStrengthTraining:
            return "근력 강화 운동"
        case .running:
            return "달리기"
        case .cycling:
            return "자전거"
        default:
            return ""
        }
    }
}
