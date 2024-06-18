//
//  ProfileView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack {
            
            HStack {
                
                NavigationLink {
                    FavoriteMusicView()
                } label: {
                    Image(systemName: "heart.circle.fill")
                        .foregroundStyle(.green)
                    Text("좋아요 표시한 곡")
                        .foregroundStyle(.white)
                }
                Spacer()
            }
            
            Spacer()
        } // VSTACK
        .padding()
        
    }
    
    
    
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(NavigationObject())
            .environmentObject(MusicPlayer(iosToWatch: iOSToWatch()))
            .modelContainer(previewRoutineContainer)
            .modelContainer(previewRecordContainer)
            .modelContainer(previewMusicContainer)
    }

}
