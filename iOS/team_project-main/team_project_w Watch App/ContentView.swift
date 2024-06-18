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
    @State var value = 0
    @Binding var path: NavigationPath
    let animation3 = Animation.smooth(duration: 1, extraBounce: 1).repeatForever()

    
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
            }
            .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
                .listStyle(.carousel)
            
        }
        .navigationTitle("루틴")
        .navigationDestination(for: ExerciseRoutineContainer.self, destination: { des in
            SessionPagingView(exerciseRoutineContainer: des)
        })
        .onAppear {
            workoutManager.requestAuthorization()
            start()
        }
        .containerBackground(.green.gradient, for: .navigation)
        
        
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
    
    
        func start() {
            startHeartRateQuery(quantityTypeIdentifier: .heartRate)
        }
    
        private func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
                query, samples, deletedObjects, queryAnchor, error in
    
                guard let samples = samples as? [HKQuantitySample] else {
                    return
                }
                self.process(samples, type: quantityTypeIdentifier)
            }
    
            let query = HKAnchoredObjectQuery(type: HKQuantityType(quantityTypeIdentifier), predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
            query.updateHandler = updateHandler
            healthStore.execute(query)
        }
    
    
        private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            var lastHeartRate = 0.0
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                    connect.sendMessage(heartRate: ["heartRate": Int(lastHeartRate)])
                }
                self.value = Int(lastHeartRate)
            }
        }
}

struct ContentScreen: View {
    @State var path = NavigationPath(["1"])
    var body: some View {
        NavigationStack {
            ContentView(path: $path)
                .environmentObject(WorkoutManager())
                .environmentObject(WatchToiOS())
                .modelContainer(previewRoutineContainer)
        }
    }
}


#Preview { @MainActor in
    ContentScreen()

}
