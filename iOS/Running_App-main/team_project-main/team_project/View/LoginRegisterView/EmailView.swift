//
//  PhoneNumView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/17/23.
//

import SwiftUI

struct EmailView: View {
    @EnvironmentObject var register: RegisterModel
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
                    Text("회원님의 이메일을 입력하세요. 이 이메일은 프로필에서 다른 사람에게 공개되지 않습니다.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("이메일", text: $email)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                    .keyboardType(.phonePad)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Text("보안 및 로그인 목적으로 BitApp에서 보내는 SMS 알림을 수신할 수 있습니다.")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                
                Button(action: {
                    register.requestEmailCode(email: email) { result in
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
                .onChange(of: email) { oldValue, newValue in
                    register.email = email
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
    EmailView(path: .constant([]))
        .environmentObject(RegisterModel())
}
