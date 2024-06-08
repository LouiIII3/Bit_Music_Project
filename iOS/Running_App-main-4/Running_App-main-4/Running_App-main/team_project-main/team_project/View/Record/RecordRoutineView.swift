//
//  RecordRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/24/24.
//

import SwiftUI
import SwiftData

struct RecordRoutineView: View {
    @MainActor 
    @Query var exerciseRecordData: [ExerciseRecordContainer]
    
    
    @State private var exerciseParts: [ExercisePart] = [] // 중복 없는 파트 목록을 저장할 변수
    
    init(date: Date) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date) // 해당 날짜의 시작
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)! // 다음 날의 시작 (해당 날짜의 종료 직전)

        _exerciseRecordData = Query(filter: #Predicate<ExerciseRecordContainer> { $0.startDate >= startDate && $0.startDate < endDate })
    }

    
    
    var body: some View {
        VStack {
            List(exerciseRecordData) { record in
                NavigationLink {
                    RecordListView(recordContainer: record)
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(record.routineName)")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundColor(.orange)
                            
                            HStack {
                                ForEach(updateExerciseParts(from: record)) { part in
                                    Text(part.rawValue)
                                        .font(.footnote)
                                        .fontWeight(.heavy)
                                        .multilineTextAlignment(.leading)
                                }
                                Spacer()
                                
                            }
                            
                            Text("\(startTimeFormat.string(from: record.startDate))~\(endTimeFormat.string(from: record.endDate)) \(record.totalTime < 60 ? record.totalTime : record.totalTime/60)\(record.totalTime < 60 ? "초" : "분")")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                }
            }
            
        }.padding()
    }
    
    // 중복 없는 파트 데이터를 업데이트하는 메소드
    func updateExerciseParts(from exercise: ExerciseRecordContainer) -> [ExercisePart] {
        var partsSet = Set<ExercisePart>()
        exercise.exerciseRecordModel.forEach { ExerciseModel in
            ExerciseModel.part.forEach({ ExercisePart in
                partsSet.insert(ExercisePart)
            })
        }
        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
    }
}

#Preview {
    NavigationStack {
        RecordRoutineView(date: Date())
            .modelContainer(previewRecordContainer)
    }
}
