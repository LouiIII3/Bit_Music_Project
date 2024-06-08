//
//  RecordListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI
import SwiftData

struct RecordListView: View {
      
    var recordContainer: ExerciseRecordContainer
    
    var body: some View {
        VStack {
            List(recordContainer.exerciseRecordModel) { record in
                NavigationLink {
                    RecordInfoView(selectedExercise: record, set: record.set, count: record.count, kg: record.kg, done: record.done)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(record.exerciseName)")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            
                            HStack {
                                ForEach(record.part) { part in
                                    Text(part.rawValue)
                                        .font(.footnote)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            
                        }
                        Spacer()
                        

                    }
                }

            }

            
            
        }.padding(10)
    }
    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    private func updateExerciseParts(from exercise: ExerciseRoutineContainer) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.exerciseDefaultModel?.forEach { ExerciseModel in
            ExerciseModel.part.forEach({ ExercisePart in
                partsSet.insert(ExercisePart)
            })
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}


#Preview {

    RecordListView(recordContainer: SampleData.recordContainer.first!)
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)

}
