//
//  NameInputView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct NickNameInputView: View {
    
    @Environment(Register.self) private var register
    @State private var pressed = false
    @Binding var path: [String]
    
    var buttonHeight: CGFloat = 40
    
    var body: some View {
        VStack {
            HStack {
                Text("닉네임 입력")
                    .font(.title3)
                    .bold()
                Spacer()
            }.padding()
            
            HStack {
                Text("회원님의 닉네임 추가하세요.")
                    .font(.callout)
                Spacer()
            }.padding(.horizontal)
            
            @Bindable var register = register
            TextField("닉네임", text: $register.nickname, prompt: Text("닉네임을 입력하세요").foregroundStyle(.gray))
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
                NameInputView(path: $path)
            }
            
            Spacer()
            
            Button(action: { path.removeAll()
            }, label: {
                Text("Button")
            })
        } //VSTACK
        
    }
}

#Preview {
    NavigationStack {
        NickNameInputView(path: .constant([]))
            .environment(Register())
    }
}
