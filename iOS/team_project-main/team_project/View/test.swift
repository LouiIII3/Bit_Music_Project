//
//  test.swift
//  team_project
//
//  Created by Taewon Yoon on 6/4/24.
//

import SwiftUI


struct test: View {
    @State private var offsetX: CGFloat = 0
    @State private var showSecondText: Bool = false

    var body: some View {
        ZStack {
            if showSecondText {
                Text("This is the second view")
                    .font(.largeTitle)
                    .offset(x: offsetX)
            } else {
                Text("Swipe to see the second view")
                    .font(.largeTitle)
                    .offset(x: offsetX)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    offsetX = value.translation.width
                }
                .onEnded { value in
                    withAnimation {
                        if value.translation.width > 100 {
                            showSecondText = true
                        } else {
                            offsetX = 0
                        }
                    }
                }
        )
    }
}

#Preview {
    test()
}
