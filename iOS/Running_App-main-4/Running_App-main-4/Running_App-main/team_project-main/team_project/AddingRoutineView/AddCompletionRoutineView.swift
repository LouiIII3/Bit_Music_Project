//
//  AddCompletionRoutineView.swift
//  team_project
//
//  Created by Taewon Yoon on 3/19/24.
//

import SwiftUI
import SwiftData

struct AddCompletionRoutineView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var dbContext
    @Binding var selectedExercises: [ExerciseDefaultModel]
//    @Query var exerciseData: ExerciseRoutineContainer
    @State var alert: Bool = false
    @State var title: String = "\(dateformat.string(from: Date()))"

    var exercise: ExerciseRoutineContainer? // 만약에 기존에 있던 저장소에 추가하려면 존재 / 처음이라면 nil이 들어있을 것임

    func saveRoutine(routineName: String, completion: @escaping (Bool) -> Void) {
        // 만약 이미 존재하는 루틴이름이라면
        let predicate = #Predicate<ExerciseRoutineContainer> { $0.routineName == routineName }
        let descriptor = FetchDescriptor<ExerciseRoutineContainer>(predicate: predicate)
        if let count = try? dbContext.fetchCount(descriptor), count > 0 {
            return completion(false)
        }
        
        // 만일 새로운 데이터라면
        guard let existData = exercise else {
            let newExerciseRoutineContainer = ExerciseRoutineContainer(routineName: routineName, exerciseDefaultModel: selectedExercises)
            dbContext.insert(newExerciseRoutineContainer)
            return completion(true)
        }
        // 만약 기존에 존재했던 데이터라면
//        let saveData = selectedExercises.filter { ExerciseDefaultModel in
//            !(existData.exerciseDefaultModel?.contains(where: { $0.exerciseName == ExerciseDefaultModel.exerciseName }) ?? false)
//        }
        // 기존에 있던 데이터 + 새로 추가하는 데이터
//        let container = ExerciseRoutineContainer(routineName: routineName, exerciseDefaultModel: saveData + selectedExercises)
        return completion(true)
        
    }
    
    var body: some View {
        VStack {
            TextField("", text: $title)
            
            List(selectedExercises) { selected in

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(selected.exerciseName)")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.orange)
                        
                        HStack {
                            ForEach(selected.part) { part in
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {

                } label: {
                    Image(systemName: "ellipsis")
                }

                
            }
        }
        .alert("존재하는 루틴이름입니다" ,isPresented: $alert) {
            Button("확인", role: .destructive) {
                
            }
        }
        .overlay {
            VStack {
                Spacer()
                Button {
                    print("루틴 저장하기")
                    saveRoutine(routineName: title) { result in
                        if !result {
                            alert.toggle()
                        } else {
                            dismiss()
                        }
                    }
                } label: {
                    Text("루틴저장")
                }

            }
        }
    }
}

#Preview {
    AddCompletionRoutineView(selectedExercises: .constant(.init()))
        .modelContainer(previewRoutineContainer)

}
