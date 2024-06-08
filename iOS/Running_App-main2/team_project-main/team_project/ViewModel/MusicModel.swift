//
//  MusicInfoModel.swift
//  team_project
//
//  Created by Taewon Yoon on 3/4/24.
//

import Foundation
import SwiftData

struct MusicInfoModel: Codable, Identifiable {
    var id: Int
    var title: String
    var artist: String
    var albumUrl: String
    var filePath: String
    var tempo: String
}



@Model
class MusicModel: Identifiable {
    var id: Int = 0
    var title: String = ""
    var artist: String = ""
    var albumUrl: String = ""
    var filePath: String = ""
    var tempo: String = ""
    
    init(id: Int, title: String, artist: String, albumUrl: String, filePath: String, tempo: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.albumUrl = albumUrl
        self.filePath = filePath
        self.tempo = tempo
    }
}


let previewMusicInfo: [MusicModel] = {
    
    return [MusicModel(id: 1, title: "Rolling in the Deep", artist: "Adele", albumUrl: "https://example.com/rolling-in-the-deep", filePath: "/path/to/rolling-in-the-deep.mp3", tempo: "95"),
            MusicModel(id: 2, title: "Shape of You", artist: "Ed Sheeran", albumUrl: "https://example.com/shape-of-you", filePath: "/path/to/shape-of-you.mp3", tempo: "96"),
            MusicModel(id: 3, title: "Someone Like You", artist: "Adele", albumUrl: "https://example.com/someone-like-you", filePath: "/path/to/someone-like-you.mp3", tempo: "67"),
            MusicModel(id: 4, title: "Bohemian Rhapsody", artist: "Queen", albumUrl: "https://example.com/bohemian-rhapsody", filePath: "/path/to/bohemian-rhapsody.mp3", tempo: "76"),
            MusicModel(id: 5, title: "Dance Monkey", artist: "Tones and I", albumUrl: "https://example.com/dance-monkey", filePath: "/path/to/dance-monkey.mp3", tempo: "98"),
            MusicModel(id: 6, title: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", albumUrl: "https://example.com/uptown-funk", filePath: "/path/to/uptown-funk.mp3", tempo: "115"),
            MusicModel(id: 7, title: "Someone You Loved", artist: "Lewis Capaldi", albumUrl: "https://example.com/someone-you-loved", filePath: "/path/to/someone-you-loved.mp3", tempo: "110"),
            MusicModel(id: 8, title: "Happy", artist: "Pharrell Williams", albumUrl: "https://example.com/happy", filePath: "/path/to/happy.mp3", tempo: "160"),
            MusicModel(id: 9, title: "Despacito", artist: "Luis Fonsi ft. Daddy Yankee", albumUrl: "https://example.com/despacito", filePath: "/path/to/despacito.mp3", tempo: "89"),
            MusicModel(id: 10, title: "Hello", artist: "Adele", albumUrl: "https://example.com/hello", filePath: "/path/to/hello.mp3", tempo: "60")]
}()
