//
//  KewView.swift
//  team_project
//
//  Created by Taewon Yoon on 11/6/23.
//

import SwiftUI

struct KeyView: View {
    @Binding var key: String
    var body: some View {
        HStack {
            Image(systemName: "key.radiowaves.forward.fill")
                .foregroundColor(key.count < 3 ? .gray : .accentColor)
            
            VStack {
                TextField("", text: $key, prompt: Text("인증키").foregroundStyle(.gray))
                    .foregroundStyle(.white)
                    .padding([.leading, .trailing], 16)
                    .textInputAutocapitalization(.never) // 첫문자 대문자 안되게 해준다.
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
    KeyView(key: .constant(""))
}
