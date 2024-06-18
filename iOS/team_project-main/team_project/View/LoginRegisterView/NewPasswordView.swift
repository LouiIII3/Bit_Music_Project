//
//  NewPasswordView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/31/24.
//

import SwiftUI

struct NewPasswordView: View {
    @Environment(Register.self) private var register
    @State private var name = ""
    @State private var pressed = false
    @State private var userid = ""
    @State private var alert: Bool = false
    @State private var message: String = ""
    @State private var password1: String = ""
    @State private var password2: String = ""
    @State private var vaildation: Bool = false
    @State private var email: String = ""
    @State private var verifiedCode = ""
    @State private var textfieldH: CGFloat = 0.0
    @State private var textfieldW: CGFloat = 0.0
    
    //    @State private var
    
    @Binding var path: [String]
    
    func vaildateText(text: String) -> Bool {
        if text.count > 6 {
            return true
        } else {
            return false
        }
    }
    
    
    var buttonHeight: CGFloat = 40
    
    var body: some View {
            
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
                
                HStack {
                    TextField("이메일", text: $email,prompt: Text("이메일").foregroundStyle(.gray))
                        .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .keyboardType(.emailAddress)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    
                    
                }
                
                Button(action: {
                    RegisterViewModel().changeRequestEmailCode(email: email) { result in
                        if result {
                            pressed.toggle()
                        } else {
                            alert.toggle()
                        }
                    }
                }, label: {
                    Text("요청")
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                        .padding(.trailing, 3)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                
                HStack {
                    Text("인증코드")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                TextField("", text: $verifiedCode, prompt: Text("인증코드").foregroundStyle(.gray))
                    .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                
                HStack {
                    Text("비밀번호 재설정")
                        .font(.title3)
                        .bold()
                    Spacer()
                }.padding()
                
                HStack {
                    
                    TextField("새 비밀번호", text: $password1, prompt: Text("새 비밀번호").foregroundStyle(.gray))
                        .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                Spacer()
                                Image(systemName: vaildation ? "checkmark.square.fill" : "checkmark.square")
                                    .foregroundStyle(vaildateText(text: password1) ? .green : .gray)
                                    .contentTransition(.symbolEffect(.replace))
                                    .padding(30)
                            }
                        }
                }
                
                HStack {
                    TextField("새 비밀번호 확인", text: $password2, prompt: Text("새 비밀번호 확인").foregroundStyle(.gray))
                        .modifier(customTextFieldModifier(roundedCorners: 15, textColor: .black))
                        .keyboardType(.emailAddress)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                Spacer()
                                Image(systemName: vaildation ? "checkmark.square.fill" : "checkmark.square")
                                    .foregroundStyle(vaildation ? .green : .gray)
                                    .contentTransition(.symbolEffect(.replace))
                                    .padding(30)
                            }
                        }
                }

                HStack {
                    Text("재설정할 회원님의 비밀번호를 입력하세요.")
                        .font(.callout)
                    Spacer()
                    
                }.padding(.horizontal)
                
                HStack {
                    Text("보안 및 로그인 목적으로 Beat Music에서 보내는 SMS 알림을 수신할 수 있습니다.")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    Spacer()
                }.padding(.horizontal)
                
                
                Button(action: {
                    if password1 != password2 {
                        alert.toggle()
                    } else {
                        // 통신하는 부분
                        RegisterViewModel().changePassword(verifyCode: verifiedCode, userid: email, password: password1) { result in
                            if result {
                                path.removeAll()
                            }
                        }
                    }
                }, label: {
                    Text("다음")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                })
                .buttonStyle(customButtonStyle(labelColor: Color.white, backgroundColor: Color.accentColor, borderColor: Color.accentColor))
                .onChange(of: password1) { oldValue, newValue in
                    if password1 == password2 {
                        vaildation = true
                    } else {
                        vaildation = false
                    }
                }
                .onChange(of: password2) { oldValue, newValue in
                    if password1 == password2 {
                        vaildation = true
                    } else {
                        vaildation = false
                    }
                }
                
                
                
                Spacer()
            } //VSTACK
        .alert("인증코드가 일치하지 않습니다", isPresented: $alert) {
            Button("확인", role: .cancel) {}
        }
    }
}

#Preview {
    NewPasswordView(path: .constant([]))
}
