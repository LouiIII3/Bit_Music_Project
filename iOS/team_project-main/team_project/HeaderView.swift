//
//  HeaderView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/28/23.
//

import SwiftUI

struct HeaderView: View {
    let tmp = ["a","b","c","d","e"]
    var images = ["figure.basketball", "figure.core.training", "figure.indoor.cycle", "figure.mind.and.body"]
    var body: some View {
        HStack {
            Text("홈")
                .font(.title)
            
            Spacer()
            
            
        }
        .padding()
        
    }
}

#Preview {
    HeaderView()
        .previewLayout(.sizeThatFits)
}
