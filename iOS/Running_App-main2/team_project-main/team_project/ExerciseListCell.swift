//
//  ExerciseListCell.swift
//  team_project
//
//  Created by Taewon Yoon on 4/29/24.
//

//import SwiftUI
//
//struct ExerciseListCell: View {
//    let exercise: ExerciseRoutineContainer
//    @Binding var pressed: Bool
//    @Binding var selectedRoutine: ExerciseRoutineContainer
//    var record: ExerciseRecordModel?
//    
//    var body: some View {
//
//    }
//    
//    private func updateExerciseParts(from exercise: ExerciseRoutineContainer) -> [ExercisePart] {
//        var partsSet = Set<ExercisePart>()
//        exercise.exerciseDefaultModel?.forEach { ExerciseModel in
//            ExerciseModel.part.forEach({ ExercisePart in
//                partsSet.insert(ExercisePart)
//            })
//        }
//        return Array(partsSet).sorted(by: { $0.rawValue < $1.rawValue }) // 정렬은 선택적
//    }
//}
//
//#Preview {
//    ExerciseListCell(exercise: SampleData.routineContainer.first!, pressed: .constant(false), selectedRoutine: .constant(SampleData.routineContainer.first!))
//}
