//
//  RoutineSearchMenuView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI

struct ToolSearchMenuView: View {
    @Binding var tool: ExerciseTool?
    @State private var scrollViewContentSize: CGSize = .zero
    let tools = ExerciseTool.allCases
    var selectedColor: Color
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(tools, id: \.self) { item in
                    Text(item.rawValue)
                        .padding(.horizontal, 5)
                        .foregroundStyle(tool == item ? selectedColor : Color.gray)
                        .onTapGesture {
                            tool = item
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
    ToolSearchMenuView(tool: .constant(.machine), selectedColor: .orange)
}

