//
//  RecordListView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/23/24.
//

import SwiftUI
import SwiftData

struct RecordListView: View {
    @State private var pressed: Bool = false
    @State private var selected: ExerciseRecordModel?
    var recordContainer: ExerciseRecordContainer
    

    
    
    var body: some View {
                        
            VStack {
                ForEach(recordContainer.exerciseRecordModel) { record in
                    NavigationLink {
                        RecordInfoView(selectedExercise: record, set: record.set, count: record.count, kg: record.kg, done: record.done)
                    } label: {
                        ReusableCell(pressed: $pressed, selected: $selected, exerciseRecordModel: record)
//                        .background(.backgroundColor2)
                    }
                    .padding()
//                    .background(Color.backgroundColor2)
                    .clipShape(.buttonBorder)
                }
                
                Spacer()
                
            }
            .padding()
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

func recordListView(recordContainer: [ExerciseRecordModel], @Binding pressed: Bool, @Binding selected: ExerciseRecordModel?) -> some View {
    ZStack {
        VStack {
            ForEach(recordContainer) { record in
                NavigationLink {
                    RecordInfoView(selectedExercise: record, set: record.set, count: record.count, kg: record.kg, done: record.done)
                } label: {
                    ReusableCell(pressed: $pressed, selected: $selected, exerciseRecordModel: record)
                }
                .padding()
                .clipShape(.buttonBorder)
            }
            
            Spacer()
            
        }
        .padding()
    }
}


#Preview {

    RecordListView(recordContainer: SampleData.recordContainer.first!)
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)

}

struct ReusableCell: View {
    @Binding var pressed: Bool
    @Binding var selected: ExerciseRecordModel?
    var exerciseRecordModel: ExerciseRecordModel
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("\(exerciseRecordModel.exerciseName)")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.orange)
                
                HStack {
                    ForEach(exerciseRecordModel.part) { part in
                        Text(part.rawValue)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.white)
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                selected = exerciseRecordModel
                pressed.toggle()
            }, label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
                
            })
        }

    }
}
