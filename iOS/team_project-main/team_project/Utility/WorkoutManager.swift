////
////  WorkoutManager.swift
////  team_project
////
////  Created by Taewon Yoon on 3/28/24.
////
//
//import Foundation
//import SwiftUI
//import HealthKit
//
//class WorkoutManager: ObservableObject {
//    // Define the type.
//    let store = HKHealthStore()
//
//    func getHealthData(completion: @escaping(Bool) -> (Void)) async {
//        let stepType = HKQuantityType(.stepCount)
//        
//        
//        // Create the descriptor.
//        let descriptor = HKSampleQueryDescriptor(
//            predicates:[.quantitySample(type: stepType)],
//            sortDescriptors: [SortDescriptor(\.endDate, order: .reverse)],
//            limit: 10)
//        
//        
//        // Launch the query and wait for the results.
//        // The system automatically sets results to [HKQuantitySample].
//        do {
//            let results = try await descriptor.result(for: store)
////            for result in results {
//                // Process the results here.
////            }
//        } catch {
//            print(error)
//            completion(false)
//        }
//        
//        
//
//    }
//}
