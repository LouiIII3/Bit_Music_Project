//
//  ControlView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI

struct ControlView: View {
    @EnvironmentObject var session: WorkoutManager
    
    var body: some View {
        
        HStack {
            Button {
                session.endWorkout()
            } label: {
                Text("종료")
                    .foregroundStyle(.red)
            }
            
            Button {
                session.togglePause()
            } label: {
                Text(session.running ? "중단" : "재개")
                    .foregroundStyle(session.running ? .yellow : .green)
            }
        }
    }
}

#Preview {
    ControlView()
}
