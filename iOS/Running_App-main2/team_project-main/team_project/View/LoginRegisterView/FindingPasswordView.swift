//
//  FindingPasswordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/31/24.
//

import SwiftUI

struct FindingPasswordView: View {
    @Environment(Register.self) private var register
    @State private var pressed = false
    @State private var email = ""
    @State private var alert: Bool = false
    @State private var message: String = ""
    @Binding var path: [String]

    
    var buttonHeight: CGFloat = 40
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
//                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("이메일 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("비밀번호를 찾고싶은 회원님의 이메일을 입력하세요.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("이메일", text: $email)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                    .keyboardType(.emailAddress)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Text("보안 및 로그인 목적으로 Beat Music에서 보내는 SMS 알림을 수신할 수 있습니다.")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                
                Button(action: {
                    RegisterViewModel().requestEmailCode(email: email) { result in
                        if result {
                            pressed.toggle()
                        } else {
                            alert.toggle()
                        }
                    }
                }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
                    EmailValidationView(email: $email, path: $path)
                }
                
                
                
                Spacer()
            } //VSTACK
        } //ZSTACK
        .alert("이미 존재하는 이메일입니다", isPresented: $alert) {
            Button("확인", role: .cancel) {}
        }
    }
}

#Preview {
    FindingPasswordView(path: .constant([]))
        .environment(Register())

}
