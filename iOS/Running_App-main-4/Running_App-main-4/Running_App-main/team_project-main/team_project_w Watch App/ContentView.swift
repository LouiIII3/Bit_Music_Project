//
//  ContentView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 3/15/24.
//

import SwiftUI
import HealthKit
import SwiftData

struct ContentView: View {
    @Environment(\.isLuminanceReduced) var isLuminanceReduced
    @EnvironmentObject var workoutManager: WorkoutManager
    var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    @EnvironmentObject var connect: WatchToiOS
    @Query var routines: [ExerciseRoutineContainer]
    //    var routines = SampleData.routineContainer
    @State var value = 0
    @Binding var path: NavigationPath
    
    
    
    
    var body: some View {
        VStack {
            List {
                ForEach(routines) { routine in
                    NavigationLink(value: routine) {
                        VStack {
                            HStack {
                                Text(routine.routineName)
                                    .foregroundStyle(.white)
                                    .font(.system(size: 25))
                                    .bold()
                                
                                Spacer()
                            }
                            // 파트 목록을 표시
                            HStack {
                                ForEach(updateExerciseParts(from: routine), id: \.self) { data in
                                    Text(data.rawValue)
                                        .foregroundStyle(.green)
                                        .font(.system(size: 15))
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }.padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                .listStyle(.carousel)
            
        }
        .navigationTitle("루틴")
        .navigationDestination(for: ExerciseRoutineContainer.self, destination: { des in
            SessionPagingView(exerciseRoutineContainer: des, path: $path)
        })
        .onAppear {
            workoutManager.requestAuthorization()
//            start()
        }
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
    
    
//        func start() {
////            autorizeHealthKit()
//            startHeartRateQuery(quantityTypeIdentifier: .heartRate)
//        }
    
//        func autorizeHealthKit() {
//            print("이상하네")
//            let healthKitTypes: Set = [HKQuantityType(.heartRate)]
//            healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { result, error in
//                if !result {
//                    print(error!.localizedDescription)
//                }
//            }
//        }
    
//        private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
//            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
//            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
//                query, samples, deletedObjects, queryAnchor, error in
//    
//                guard let samples = samples as? [HKQuantitySample] else {
//                    return
//                }
//                self.process(samples, type: quantityTypeIdentifier)
//            }
//    
//            let query = HKAnchoredObjectQuery(type: HKQuantityType(quantityTypeIdentifier), predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
//            query.updateHandler = updateHandler
//            healthStore.execute(query)
//        }
//    
//    
//        private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
//            var lastHeartRate = 0.0
//            for sample in samples {
//                if type == .heartRate {
//                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
//                    connect.sendMessage(message: ["heartRate": Int(lastHeartRate)])
//                }
//                self.value = Int(lastHeartRate)
//            }
//        }
}

struct ContentScreen: View {
    
    var body: some View {
        NavigationStack {
            ContentView(path: .constant(NavigationPath()))
        }
    }
}

#Preview { @MainActor in
    ContentScreen()
        .environmentObject(WorkoutManager())
        .environmentObject(WatchToiOS())
        .modelContainer(previewRoutineContainer)
}
