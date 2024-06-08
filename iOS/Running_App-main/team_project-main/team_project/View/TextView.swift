//
//  TextView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI
import SwiftData

struct TextView: View {
    
    @Query var exerciseRecordContainer: [ExerciseRecordContainer]
    
    var body: some View {
        List(exerciseRecordContainer) { record in
            Text(record.exerciseRecordModel.first?.exerciseName ?? "값없음")
//            Text(record.?.first?.exerciseName ?? "값이 없음")
        }.onAppear {
            print(exerciseRecordContainer.count)
        }
//        Text("1")
        
    }
}

#Preview {
    TextView()
}
