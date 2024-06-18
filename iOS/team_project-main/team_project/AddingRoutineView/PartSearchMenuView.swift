//
//  PartSearchMenuView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import Foundation
import SwiftUI

struct PartSearchMenuView: View {
    @Binding var part: ExercisePart?
    @State private var scrollViewContentSize: CGSize = .zero
    let parts = ExercisePart.allCases
    var selectedColor: Color
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(parts, id: \.self) { item in
                    Text(item.rawValue)
                        .padding(.horizontal, 5)
                        .foregroundStyle(part?.rawValue == item.rawValue ? selectedColor : Color.gray)
                        .onTapGesture {
                            part = item
                        }
                }
            }
            .background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        scrollViewContentSize = geo.size
                    }
                    return Color.clear
                }
            )
        }
        .frame(
            maxWidth: scrollViewContentSize.width
        )
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

#Preview {
    PartSearchMenuView(part: .constant(.back), selectedColor: .gray)
}
