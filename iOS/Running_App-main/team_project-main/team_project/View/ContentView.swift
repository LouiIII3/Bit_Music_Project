//
//  ContentView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var appear = false


    // MARK: - FUNCTIONS

    var body: some View {
        NavigationStack {
            
            TabView {
                MainViewContainer()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                RecordViewContainer()
                    .tabItem {
                        Image(systemName: "calendar")
                    }
                
                MyPageView()
                    .tabItem {
                        Image(systemName: "person")
                    }
            }
            .scaleEffect(appear ? 1 : 0)
            .onAppear {
                withAnimation(.easeOut) {
                    appear = true
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(TimerManager())
}
