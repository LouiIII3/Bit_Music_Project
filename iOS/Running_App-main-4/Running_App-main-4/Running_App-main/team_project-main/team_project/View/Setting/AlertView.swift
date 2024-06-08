//
//  AlertView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI

struct AlertView: View {
    var body: some View {
        VStack {
            
            VStack(spacing: 7) {
                Text("기기 알림을 켜고 빠르게 소식을 받아보세요!")
                    .bold()
                Text("기기에서 설정이 불가한 경우, 아래의 '기기 알림 켜기'를 눌러주세요.")
                    .font(.system(size: 12))
            }
            
            
            SettingToggleView(name: "일반 푸시")
            SettingToggleView(name: "마케팅 푸시")
            
            Button(action: {
                
            }, label: {
                Text("기기 알림 켜기")
            })
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AlertView()
}
