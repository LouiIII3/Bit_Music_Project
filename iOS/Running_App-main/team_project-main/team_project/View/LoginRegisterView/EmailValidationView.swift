//
//  EmailValidationView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/24/24.
//

import SwiftUI

struct EmailValidationView: View {
    @EnvironmentObject var register: RegisterModel
    @State private var verifiedCode = ""
    @State private var pressed = false
    @Binding var email: String
    @Binding var path: [String]
    @State private var alert: Bool = false

    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
//                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("인증 코드 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("To confirm your account, enter the 6-digit code we sent to ") + Text(email).bold()
                    
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("휴대폰 번호", text: $verifiedCode)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .gray))
                    .keyboardType(.phonePad)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Text("보안 및 로그인 목적으로 Instagram에서 보내는 SMS 알림을 수신할 수 있습니다.")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                
                Button(action: { 
                    register.verifyEmailCode(verifycode: verifiedCode) { result in
                        if result {
//                            pressed.toggle()
                            register.register { resulst in
                                if result {
                                    path.removeAll()
                                }
                            }
                        } else {
                            print("인증코드 인증 실패")
                        }
                    }

                }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
//                    ProfilePictureView(path: $path)
                }
                
                Button(action: {
                    register.requestEmailCode(email: email) {  result in
                    }
                    
                }, label: {
                    Text("코드를 받지 못했습니다")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.gray, backgroundColor: Color.clear, borderColor: Color.accentColor))
                
                
                Spacer()
            } //VSTACK
            .onChange(of: verifiedCode) {
                register.verifiedCode = verifiedCode
            }
            
        } //ZSTACK
        
    }
}

#Preview {
    EmailValidationView(email: .constant("abc@naver.com"), path: .constant([]))
}
