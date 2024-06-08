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
        let container = try ModelContainer(for: ExerciseRoutineContainer.self, ExerciseDefaultModel.self, ExerciseRecordContainer.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
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
        let container = try ModelContainer(for: ExerciseRoutineContainer.self, ExerciseDefaultModel.self, ExerciseRecordContainer.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        SampleData.recordContainer.forEach { ExerciseRecordContainer in
            container.mainContext.insert(ExerciseRecordContainer)
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()

struct SampleData {
    struct MusicInfoModel: Decodable, Identifiable, Equatable {
        var id: Int
        var title: String
        var artist: String
        var albumUrl: String
        var filePath: String
        var tempo: String
    }
    static let exerciseDefaultModel: [ExerciseDefaultModel] = {
        return [ExerciseDefaultModel(exerciseName: "랫풀다운", part: [.back], tool: .machine),
                ExerciseDefaultModel(exerciseName: "데드리프트", part: [.back, .hamstrings], tool: .barbell)]
    }()
    static let routineContainer: [ExerciseRoutineContainer] = {
        return [ExerciseRoutineContainer(routineName: "등하는날", exerciseDefaultModel: exerciseDefaultModel),
                ExerciseRoutineContainer(routineName: "하체하는날", exerciseDefaultModel: exerciseDefaultModel),
                ExerciseRoutineContainer(routineName: "어깨하는날", exerciseDefaultModel: exerciseDefaultModel),
                ExerciseRoutineContainer(routineName: "이두하는날", exerciseDefaultModel: exerciseDefaultModel)]
    }()
    
    static let exerciseRecordModel: [ExerciseRecordModel] = {
        return [ExerciseRecordModel(exerciseName: "랫풀다운", part: [.back], tool: .machine, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false]),
                ExerciseRecordModel(exerciseName: "데드리프트", part: [.back, .hamstrings], tool: .barbell, set: 5, count: [0,0,0,0,0], kg: [0,0,0,0,0], done: [false,false,false,false,false])]
    }()
    
    static let recordContainer = [ExerciseRecordContainer(startDate: Date(), endDate: Date(), totalTime: 24, routineName: "등하는날", exerciseRecordModel: exerciseRecordModel)]
    
    let musicInfo: [MusicInfoModel] = [
        MusicInfoModel(id: 1, title: "Rolling in the Deep", artist: "Adele", albumUrl: "https://example.com/rolling-in-the-deep", filePath: "/path/to/rolling-in-the-deep.mp3", tempo: "95"),
        MusicInfoModel(id: 2, title: "Shape of You", artist: "Ed Sheeran", albumUrl: "https://example.com/shape-of-you", filePath: "/path/to/shape-of-you.mp3", tempo: "96"),
        MusicInfoModel(id: 3, title: "Someone Like You", artist: "Adele", albumUrl: "https://example.com/someone-like-you", filePath: "/path/to/someone-like-you.mp3", tempo: "67"),
        MusicInfoModel(id: 4, title: "Bohemian Rhapsody", artist: "Queen", albumUrl: "https://example.com/bohemian-rhapsody", filePath: "/path/to/bohemian-rhapsody.mp3", tempo: "76"),
        MusicInfoModel(id: 5, title: "Dance Monkey", artist: "Tones and I", albumUrl: "https://example.com/dance-monkey", filePath: "/path/to/dance-monkey.mp3", tempo: "98"),
        MusicInfoModel(id: 6, title: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", albumUrl: "https://example.com/uptown-funk", filePath: "/path/to/uptown-funk.mp3", tempo: "115"),
        MusicInfoModel(id: 7, title: "Someone You Loved", artist: "Lewis Capaldi", albumUrl: "https://example.com/someone-you-loved", filePath: "/path/to/someone-you-loved.mp3", tempo: "110"),
        MusicInfoModel(id: 8, title: "Happy", artist: "Pharrell Williams", albumUrl: "https://example.com/happy", filePath: "/path/to/happy.mp3", tempo: "160"),
        MusicInfoModel(id: 9, title: "Despacito", artist: "Luis Fonsi ft. Daddy Yankee", albumUrl: "https://example.com/despacito", filePath: "/path/to/despacito.mp3", tempo: "89"),
        MusicInfoModel(id: 10, title: "Hello", artist: "Adele", albumUrl: "https://example.com/hello", filePath: "/path/to/hello.mp3", tempo: "60")
    ]

}
