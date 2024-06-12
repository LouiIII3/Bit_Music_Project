//
//  CustomTabBarView.swift
//  team_project
//
//  Created by Taewon Yoon on 4/28/24.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem
    @Environment(TimerManager.self) var timer

    
    var body: some View {
        VStack {
            if timer.showTimer {
                NavigationLink {
                    if let data = timer.exerciseRoutineContainer {
                        RoutineListView(exerciseContainer: data)
                    }
                } label: {
                    if let data = timer.exerciseRoutineContainer {
                        TimerView(exerciseContainer: data)
                    }
                }
            }
            tabBar
                .onChange(of: selection) { oldValue, newValue in
                    withAnimation(.easeInOut) {
                        localSelection = newValue
                    }
                }
        }
    }
}

#Preview {

    VStack {
        let tab: TabBarItem = .home
        Spacer()
        CustomTabBarView(tabs: [
            .home, .calendar, .profile
        ], selection: .constant(tab), localSelection: tab)
        .environment(TimerManager())
    }
}

extension CustomTabBarView {

    private func switchToTab(tab: TabBarItem) {
            selection = tab
    }
    
    private func tabview(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                }
            }
        )
    }
    
    private var tabBar: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabview(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(5)
//        .background(Color.bg300.ignoresSafeArea(edges: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
    
}
