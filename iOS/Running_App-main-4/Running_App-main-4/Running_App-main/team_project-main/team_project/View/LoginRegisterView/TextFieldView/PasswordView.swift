//
//  PasswordView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import SwiftUI

struct PasswordView: View {
    @Binding var password: String
    var body: some View {
        HStack {
            Image(systemName: "key.fill")
                .foregroundColor(password.count < 6 ? .gray : .accentColor)
            
            VStack {
                SecureField("", text: $password, prompt: Text("비밀번호를 입력하세요").foregroundStyle(.gray))
                    .foregroundStyle(.white)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .autocorrectionDisabled()
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
            }
        } // HSTACK
    }
}

#Preview {
    PasswordView(password: .constant("abcd"))
        .background {
            Color.black
        }
}
