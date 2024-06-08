//
//  ExerciseList.swift
//  team_project
//
//  Created by Taewon Yoon on 10/29/23.
//

import SwiftUI

struct ExerciseListView: View {
    @Binding var targetPart: ExercisePart?
    @Binding var targetTool: ExerciseTool?
    @Binding var selectedExercises: [ExerciseDefaultModel]
    
    var existedExercise: ExerciseRoutineContainer?
    
    var body: some View {
        ScrollView {
            ForEach(filteredExercises, id: \.self) { exercise in
                ExerciseListCellView(exercise: exercise, isSelected: selectedExercises.contains(exercise))
                    .onTapGesture {
                        if selectedExercises.contains(exercise) {
                            selectedExercises.removeAll(where: { $0.id == exercise.id })
                        } else {
                            selectedExercises.append(exercise)
                        }
                    }
            }
            .onAppear(perform: {
            })
        }
        
        .navigationTitle("Exercises")
    }
    
    var filteredExercises: [ExerciseDefaultModel] {
        switch targetPart {
        case .wholeBody:
            if targetTool == .wholeBody { // 모든 도구
                return ExerciseData.allExercies // contain로 != existed한 데이터와 비교해 걸러내기
            } else { // 특정 도구
                return ExerciseData.allExercies.filter { exercise in
                    return exercise.tool == targetTool
                }
            }
            
        case .chest:
            if targetTool == .wholeBody {
                return ExerciseData.chestExercises
            } else { // 특정 도구
                // 가슴 운동중에서 걸러낸다
                
//                return ExerciseData.chestExercises.filter { new in
//                    // 만약 존재하는 운동 중에서 존재하지 않는것이 나타난다면
//                    return existedExercise?.exercise.contains(where: { existed in
//                        return (existed.exerciseName != new.exerciseName)
//                    }) ?? true
//                }
                
                let filteredExercises = ExerciseData.chestExercises.filter { exercise in
                    // 첫 번째 조건: targetPart와 targetTool에 맞는 운동인지 확인
                    let matchesTarget = exercise.part.first == targetPart && exercise.tool == targetTool
                    
                    // 두 번째 조건: existedExercise?.routines에 이미 존재하지 않는 운동인지 확인
                    let notAlreadyExisted = existedExercise?.exerciseDefaultModel?.contains(where: { ExerciseModel in
                        return exercise.exerciseName == ExerciseModel.exerciseName
                    }) ?? false
                    
                    return matchesTarget && !notAlreadyExisted
//                    let notAlreadyExisted = (existedExercise?.routines.contains(where: { ex in // 하나라도 존재한다면 true
//                        return exercise.exerciseName == ex.exerciseName
//                    }) ?? false)
//                    // 두 조건을 모두 만족하는지 반환
//                    return matchesTarget && !notAlreadyExisted
                }
                
//                print("그래서 찾은거:\(filteredExercises.description)")
                
                return filteredExercises
            }
        case .back: break
            
        case .shoulders: break
            
        case .triceps: break
            
        case .biceps: break
            
        case .forearms: break
            
        case .abs: break
            
        case .glutes: break
            
        case .hamstrings: break
            
        case .quadriceps: break
            
        case .trapezius: break
            
        case .calves: break
            
        case nil: break
            
        }
        return ExerciseData.chestExercises.filter { exercise in
            return exercise.part.first == targetPart && exercise.tool == targetTool
        }
    }
}

#Preview { @MainActor in
    ExerciseListView(targetPart: .constant(.hamstrings), targetTool: .constant(.machine), selectedExercises: .constant(.init()))
        .modelContainer(previewRoutineContainer)
}

/*
 그래서 찾은거:[team_project.ExerciseDataModel(id: 8E2B0B40-36CB-4D71-8076-B1C3D08D506C, exerciseName: "디클라인 푸시 업", part: [team_project.ExercisePart.chest,
 이미 존재하는것들Optional("[team_project.ExerciseDataModel(id: 343EC5EB-A494-44C6-AEF3-46CD8EC3EE9F, exerciseName: \"디클라인 푸시 업\", part: [team_project.ExercisePart.chest, team_project.ExercisePart.shoulders], tool: team_project.ExerciseTool.bodyWeight, checked: false)
 */
