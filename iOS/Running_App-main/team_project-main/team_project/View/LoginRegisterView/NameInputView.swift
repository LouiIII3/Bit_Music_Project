//
//  NameInputView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct NameInputView: View {
    
    @EnvironmentObject var register: RegisterModel

    @State private var name = ""
    @State private var pressed = false
    @Binding var path: [String]

    var buttonHeight: CGFloat = 40

    var body: some View {
        ZStack {
//            LinearGradient(gradient: Gradient(colors: [Color.login, Color.loginColor2, Color.loginColor3]), startPoint: .topLeading, endPoint: .trailing)
//                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("이름 입력")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    Text("친구들이 회원님을 찾을 수 있도록 이름을 추가하세요.")
                        .font(.callout)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("성명", text: $name)
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .gray))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                Button(action: {
                    pressed.toggle()
                }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: buttonHeight)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .navigationDestination(isPresented: $pressed) {
                    PasswordInputView(path: $path)
                }
                
                Spacer()
                
                Button(action: { path.removeAll()
                }, label: {
                    Text("Button")
                })
            } //VSTACK
            .onChange(of: name) {
                register.name = name
            }
        } //ZSTACK
        
    }
}

#Preview {
    NameInputView(path: .constant([]))
        .environmentObject(RegisterModel())
}
