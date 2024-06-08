//
//  RoutineTableView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/25/24.
//

import SwiftUI

struct RoutineTableView: View {
    @Binding var set: Int
    @Binding var count: [String]
    @Binding var kg: [String]
    @Binding var done: [Bool]
    var selectedExercise: ExerciseDefaultModel // 선택된 단독 데이터

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            VStack {
                Text("세트")
                    .frame(minWidth: 50, alignment: .center)
                ForEach(0..<selectedExercise.set) { set in
                    Text(String(set))
                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                }
            } //HSTACK
            
            VStack {
                Text("KG")
                    .frame(minWidth: 50, alignment: .center)
                ForEach(Array(selectedExercise.kg.enumerated()), id: \.offset) { index, kg in
                    TextField("\(kg)", text: $kg[index])
                        .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                        .keyboardType(.numberPad)
                }
            } //VSTACK
//                        Array(data.enumerated())
            VStack {
                Text("횟수")
                    .frame(minWidth: 50, alignment: .center)
                ForEach(Array(selectedExercise.count.enumerated()), id: \.offset) { index, count in
                    TextField("\(count)", text: $count[index])
                        .multilineTextAlignment(.center) // 텍스트를 가운데 정렬
                        .frame(minWidth: 50, minHeight: 50, alignment: .center)
                        .keyboardType(.numberPad)
                }
            } //VSTACK
            
            VStack {
                Text("완료")
                    .frame(minWidth: 50, alignment: .center)
                ForEach(Array(selectedExercise.done.enumerated()), id: \.offset) { index, done in
                    Button(action: {
                        // `selectedExercise.done` 배열의 `index`에 해당하는 값을 toggle 처리
                        self.done[index].toggle()
                    }, label: {
                        Image(systemName: self.done[index] ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(self.done[index]
                                             ? .green : .gray)
                            .frame(minWidth: 50, minHeight: 50, alignment: .center)
                    })
                }
            } //VSTACK
            
            Spacer()
        }
    }
}

//#Preview {
//    RoutineTableView()
//}
