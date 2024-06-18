//
//  LoginView.swift
//  Clone_instagram
//
//  Created by Taewon Yoon on 12/15/23.
//

import SwiftUI

struct customTextFieldModifier: ViewModifier {
    var roundedCorners: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .foregroundStyle(textColor)
            .clipShape(RoundedRectangle(cornerRadius: roundedCorners))
            .font(.system(size: 18))
            .shadow(radius: 1)
    }
}

struct customButtonStyle: ButtonStyle {
    var labelColor: Color
    var backgroundColor: Color
    var borderColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        let pressed = configuration.isPressed
        return configuration.label
            .foregroundStyle(labelColor)
            .contentShape(Capsule()) // 버튼이 클릭될 프레임 선택
            .background(Capsule().fill(backgroundColor))
            .scaleEffect(pressed ? 0.98 : 1.0)
            .animation(.easeIn(duration: 0.2), value: pressed)
            .opacity(pressed ? 0.9 : 1)
            .overlay(
                Capsule()
                    .stroke(borderColor, lineWidth: 1.0)
                    .scaleEffect(pressed ? 0.98 : 1.0)
                    .animation(.easeIn(duration: 0.2), value: pressed)
                    .opacity(pressed ? 0.9 : 1)
            )
            .padding([.horizontal])
            .padding(.top, 5)
        
    }
}


struct LoginView: View {
    @EnvironmentObject var isLogged: LoginStatus
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var pressed = false
    @State private var path: [String] = []
    @State private var errorPressed = false
    var loginmodel = LoginViewModel()
    
    
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                
                VStack {
                    
                    Spacer()
                    
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)

                    Spacer()
                    
                    
                    HStack {
                        Text("Username")
                            .padding(.horizontal)
                            .bold()
                        Spacer()
                    }
                    TextField(text: $id, prompt: Text("사용자 아이디를 입력하세요").foregroundStyle(.gray)) {}.modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .frame(maxWidth: .infinity)
                        .padding([.horizontal, .bottom])
                        .autocorrectionDisabled()
                    
                    HStack {
                        Text("Password")
                            .padding(.horizontal)
                            .bold()
                        Spacer()
                    }
                    
                    SecureField(text: $password, prompt: Text("비밀번호를 입력하세요").foregroundStyle(.gray)) {}
                        .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .autocorrectionDisabled()
                    
                    Button(action: {
                        loginmodel.login(username: id, password: password) { result in
                            if result {
                                isLogged.isLogged = true
                                print("로그인 성공")
                            } else {
                                print("로그인 실패")
                            }
                        }
                    }, label: {
                        Text("로그인")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                    })
                    .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                    
                    
                    Button {
                        path.append("NewPasswordView")
                    } label: {
                        Text("비밀번호를 잊으셨나요?")
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                    }
                    .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))

                    
                    Spacer(minLength: 220)
                    
                    //MARK: 계정 만드는 파트
                    
                    NavigationLink(value: "LoginView") {
                        Text("새 계정 만들기")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .contentShape(Capsule()) // 버튼이 클릭될 프레임 선택
                            .background(Capsule().fill(Color.clear))
                            .scaleEffect(pressed ? 0.98 : 1.0)
                            .animation(.easeIn(duration: 0.2), value: pressed)
                            .opacity(pressed ? 0.9 : 1)
                            .overlay(
                                Capsule()
                                    .stroke(Color.accentColor, lineWidth: 1.0)
                                    .scaleEffect(pressed ? 0.98 : 1.0)
                                    .animation(.easeIn(duration: 0.2), value: pressed)
                                    .opacity(pressed ? 0.9 : 1)
                            )
                            .onTapGesture(perform: {
                                path.append("LoginView")
                            })
                    }.padding(.horizontal)
                    
                    Text("made by taewon")
                        .padding(.top)
                } //VSTACK
                .navigationDestination(for: String.self) { destination in
                    if destination == "NickNameInputView" {
                        NickNameInputView(path: $path)
                    } else {
                        NewPasswordView(path: $path)
                    }
                }
                .alert("로그인 실패", isPresented: $errorPressed) {
                    Button("CANCLE", role: .cancel) {}
                    Button("OK", role: .destructive) {}
                } message: {
                    Text("다시 로그인하세요")
                }
            } //ZSTACK
            .ignoresSafeArea(.keyboard, edges: .bottom)
        } //NavigationStack
    }
    
}

#Preview {
    LoginView()
}
