//
//  PreViewData.swift
//  team_project
//
//  Created by Taewon Yoon on 3/21/24.
//

import Foundation
import SwiftUI


struct PreviewData {
    var previewExerciseRoutineContainer: ExerciseRoutineContainer = .init(id: nil, routineName: "루틴1", exerciseDefaultModel: [.init(exerciseName: "백", part: [.abs], tool: .barbell)])

    let previewRegisterViewModel = Register()
}

@Observable
class NavigationObject: ObservableObject {
    var path: NavigationPath
    var tab: Bool
    
    init() {
        self.path = .init()
        self.tab = false
    }
}
