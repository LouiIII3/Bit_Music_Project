//
//  MusicInfoModel.swift
//  team_project
//
//  Created by Taewon Yoon on 3/4/24.
//

import Foundation

struct MusicInfoModel: Decodable, Identifiable, Equatable {
    var id: Int
    var title: String
    var artist: String
    var albumUrl: String
    var filePath: String
    var tempo: String
}
