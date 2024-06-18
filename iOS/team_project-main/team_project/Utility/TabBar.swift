//
//  TabBar.swift
//  team_project
//
//  Created by Taewon Yoon on 4/28/24.
//

import Foundation
import SwiftUI

// 탭바에 사용될 items
enum TabBarItem: Hashable {
    case home, calendar, profile
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .calendar: return "calendar"
        case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .calendar: return "기록"
        case .profile: return "프로필"
        }
    }
    
}
