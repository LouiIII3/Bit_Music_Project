//
//  ExerciseListCellView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/17/24.
//

import SwiftUI

struct ExerciseListCellView: View {
    var exercise: ExerciseDefaultModel
    var isSelected: Bool = false
    var completion: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(exercise.exerciseName)
                        .font(.headline)
                    
                    Image(systemName: isSelected && !completion ? "checkmark" : "")
                        .foregroundStyle(isSelected && !completion ? .green : .gray)
                    Spacer()
                }
                HStack {
                    Text(exercise.part.map { $0.rawValue }.joined(separator: ", "))
                    Spacer()
                }
            }
            Button(action: {
                print("버튼 클릭")
            }, label: {
                Image(systemName: "ellipsis")
                    .padding()
            })
            
        }
        .padding()
        .contentShape(.rect)
    }
}

#Preview {
    ExerciseListCellView(exercise: ExerciseData.archerPushup)
}
