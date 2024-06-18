//
//  RoutineListCell.swift
//  team_project
//
//  Created by Taewon Yoon on 3/20/24.
//

import SwiftUI

struct RoutineListCell: View {
    
    var model: ExerciseDataModel
    
    var body: some View {
        HStack() {
//            Image(model.image)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 90, height: 90)
//                .clipShape(
//                    RoundedRectangle(cornerRadius: 12)
//                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(model.exerciseName)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.orange)
                
                HStack {
                    ForEach(model.part) { part in
                        Text(part.rawValue)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)

                    }
                }
            }
            Spacer()
        }.padding()
    }
}

#Preview {
    RoutineListCell(model: .init(exerciseName: "등복근", part: [.abs, .back], tool: .barbell))
}
