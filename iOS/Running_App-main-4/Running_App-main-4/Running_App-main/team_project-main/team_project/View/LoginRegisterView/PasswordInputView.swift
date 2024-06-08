//
//  PasswordInputView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/24/24.
//

import SwiftUI

struct PasswordInputView: View {
    
//    @Environment(RegisterModel.self) private var userinfo
    @EnvironmentObject var register: RegisterModel
    @Binding var path: [String]
    @State private var password = ""
    @State private var pressed = false

    var buttonHeight: CGFloat = 40
    
    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
//                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("비밀번호 만들기")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                SecureField("비밀번호 만들기", text: $password)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .gray))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Button(action: {
//                    userinfo.viewPath.append("PasswordInputView")
                    pressed.toggle()
                }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
//                    BirthView(path: $path)
                    EmailView(path: $path)
                }
                
                
                Spacer()
                
                Button(action: { path.removeAll()
                }, label: {
                    Text("Button")
                })
            } //VSTACK
            .onChange(of: password) {
                register.password = password
            }
        } //ZSTACK
        
    }
}

#Preview {
    PasswordInputView(path: .constant([]))
        .environmentObject(RegisterModel())
}
