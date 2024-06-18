//
//  SearchBar.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField("Search", text: $text)
                    .foregroundColor(.primary)

                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
