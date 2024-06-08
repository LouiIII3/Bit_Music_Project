import SwiftUI

struct SettingView: View {
    
    @Binding var path: [String]
    @EnvironmentObject var isLogged: LoginStatus

    var body: some View {
        List {
            Section("내 정보") {
                
            }
            Section("앱 설정") {
                SettingToggleView(name: "일반 푸시")
            }
            Section("계정 관리") {
                NavigationLink(destination: AccountSetting(path: $path)) {
                    Text("계정 설정")
                }
//                Button(action: { login.toggle() }, label: {
//                    Text("로그아웃")
//                })
                Button {
                    // 로그아웃시 키체인 삭제,
                    do {
                        try KeyChain.delete()
                        isLogged.isLogged = false
                        print("isLogged 수정됌: \(isLogged.isLogged)")
                    } catch {
                        print("키체인 삭제 에러: \(error.localizedDescription)")
                        return
                    }
                } label: {
                    Text("로그아웃")
                }

            }

        }
//        List {
//            Section("내 정보") {
//                
//
//            }
//            
//            Section("앱 설정") {
//                SettingToggleView(name: "일반 푸시")
//                ForEach(games, id: \.name) { game in
//                    NavigationLink(value: game) {
//                        Text(game.name)
//                    }
//                }
//            }
//            
//            Section("계정 관리") {
//                ForEach(games, id: \.name) { game in
//                    NavigationLink(value: game) {
//                        Text(game.name)
//                    }
//                }
//            }
//        }
        .navigationTitle("마이페이지")

    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(path: .constant(["aaa","bbb","ccc"]))
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

//struct AppSetting: Hashable {
//    let
//}
