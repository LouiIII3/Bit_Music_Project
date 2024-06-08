//
//  IdView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import SwiftUI

struct IdView: View {
    @Binding var id: String
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .foregroundColor(id.count < 10 ? .gray : .green)
            
            VStack {
                TextField("", text: $id, prompt: Text("아이디를 입력하세요").foregroundStyle(.gray))
                    .foregroundStyle(.white)
                    .padding(.leading, 16)
                    .padding(.trailing, 16)
                    .textInputAutocapitalization(.never) // 소문자로 시작하기
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
    IdView(id: .constant("happyytw"))
        .background {
            Color.black
        }
}
