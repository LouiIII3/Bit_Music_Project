//
//  AccountSetting.swift
//  team_project
//
//  Created by Taewon Yoon on 10/27/23.
//

import SwiftUI

struct AccountSetting: View {
    
    // MARK: - PROPERTIES
    
    var model = AccountSettingModel()
    
    @Binding var path: [String]
    @State private var id: String = ""
    @State private var passWord: String = ""
    @State private var newPassWord: String = ""
    @State private var checkPassWord: String = ""
    @State private var alert: Bool = false
    @State private var response: RegisterResponseDTD?
    
    // MARK: - BODY
    
    var body: some View {
        Text("비밀번호 변경")
        VStack(spacing: 16) {
            TextField("", text: $id, prompt: Text("현재 아이디"))
            SecureField("", text: $passWord, prompt: Text("현재 비밀번호"))
            SecureField("", text: $newPassWord, prompt: Text("새 비밀번호"))
            SecureField("", text: $checkPassWord, prompt: Text("새 비밀번호 확인"))
        }.padding(20)
        Button(action: {
            Task {
                response = await model.changePassWord(userid: id, originPassword: passWord, newPassword: newPassWord)
                if response?.error == true {
                    alert.toggle()
                } else {
                    print("비밀번호 변경 성공")
                }
            }
        }, label: {
            Text("변경하기").frame(height: 5)
        })
//        .buttonStyle(GradientBackgroundStyle())
        .alert(response?.reason ?? "비밀번호 변경 실패", isPresented: $alert) {
            Button("확인", role: .cancel) {}
        }
        
        Spacer()
    }
}

#Preview {
    AccountSetting(path: .constant([]))
}
