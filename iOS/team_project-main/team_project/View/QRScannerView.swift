//
//  QRScannerView.swift
//  team_project
//
//  Created by Taewon Yoon on 5/7/24.
//

import SwiftUI
import CodeScanner
import SwiftData


struct QRScannerView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var dbContext
    @Binding var showAlert: Bool
    @State var recordContainer: [ExerciseRecordContainer]?
    @Query var exerciseData: [ExerciseRoutineContainer]
    @State private var tmp = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                if recordContainer == nil {
                    CodeScannerView(codeTypes: [.qr], videoCaptureDevice: .default(.builtInTripleCamera, for: .audio, position: .back)) { response in
                        switch response {
                        case .success(let result):
                            print("Found code: \(result.string)")
                            if let data = result.string.data(using: .utf8) {
                                Task {
                                    do {
                                        let decoder = JSONDecoder()
                                        decoder.dateDecodingStrategy = .iso8601
                                        recordContainer = try decoder.decode([ExerciseRecordContainer].self, from: data)
                                    } catch {
                                        print(error)
                                        print(error.localizedDescription)
                                        showAlert = true
                                        dismiss()
                                    }
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                            dismiss()
                        }
                    }
                } else {
                    HStack {
                        if let container = recordContainer?.first {
                            RecordListView(recordContainer: container)
                                .overlay(alignment: .bottom) {
                                    HStack {
                                        Button {
                                            let recordContainer = ExerciseRecordContainer(startDate: container.startDate, endDate: container.endDate, totalTime: container.totalTime, routineName: container.routineName, exerciseRecordModel: container.exerciseRecordModel)
                                            
                                            dbContext.insert(recordContainer)
                                            dismiss()
                                        } label: {
                                            Text("저장하기")
                                        }
                                        .buttonStyle(BorderedProminentButtonStyle())
                                        .tint(.green)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 100, height: 50)
                                        
                                        Button {
                                            print("다시찍기")
                                            recordContainer = nil
                                        } label: {
                                            Text("다시찍기")
                                        }
                                        .buttonStyle(BorderedProminentButtonStyle())
                                        .tint(.red)
                                        .foregroundStyle(Color.white)
                                        .frame(width: 100, height: 50)
                                    }
                                }
                                .navigationTitle(container.routineName)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
            }
        }
    }
}




#Preview {
    QRScannerView(showAlert: .constant(false))
}


