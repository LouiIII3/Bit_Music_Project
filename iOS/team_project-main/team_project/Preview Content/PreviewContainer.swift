//
//  PreviewContainer.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import Foundation
import SwiftData


@MainActor
let previewRoutineContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ExerciseRoutineContainer.self, ExerciseDefaultModel.self, ExerciseRecordContainer.self, MusicModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        SampleData.routineContainer.forEach { ExerciseRoutineContainer in
            container.mainContext.insert(ExerciseRoutineContainer)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@MainActor
let previewRecordContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ExerciseRoutineContainer.self, ExerciseDefaultModel.self, ExerciseRecordContainer.self,MusicModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

        SampleData.recordContainer.forEach { ExerciseRecordContainer in
            container.mainContext.insert(ExerciseRecordContainer)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

@MainActor
let previewMusicContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: ExerciseRoutineContainer.self, ExerciseDefaultModel.self, ExerciseRecordContainer.self,MusicModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        previewMusicInfo.forEach { MusicInfoModel in
            container.mainContext.insert(MusicInfoModel)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

struct SampleData {
    static let exerciseDefaultModel: [ExerciseDefaultModel] = {
        return [ExerciseDefaultModel(exerciseName: "랫풀다운", part: [.back], tool: .machine),
                ExerciseDefaultModel(exerciseName: "데드리프트", part: [.back, .hamstrings], tool: .barbell)]
    }()
    static let routineContainer: [ExerciseRoutineContainer] = {
        return [ExerciseRoutineContainer(routineName: "등하는날", exerciseDefaultModel: exerciseDefaultModel)]
    }()
    
    static let exerciseRecordModel: [ExerciseRecordModel] = {
        return [ExerciseRecordModel(exerciseName: "랫풀다운", part: [.back], tool: .machine, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false]),
                ExerciseRecordModel(exerciseName: "데드리프트", part: [.back, .hamstrings], tool: .barbell, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])]
    }()
    
    static let recordContainer = [ExerciseRecordContainer(startDate: Date(), endDate: Date(), totalTime: 24, routineName: "등하는날", exerciseRecordModel: exerciseRecordModel)]
}

