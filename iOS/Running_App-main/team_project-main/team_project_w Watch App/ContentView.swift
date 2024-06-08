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
    private var healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    @Query var exerciseData: [ExerciseRoutineContainer]
    


    
    var body: some View {
        RoutineView(exerciseData: exerciseData)
        
        Text("흠")
            .onAppear {
                print(exerciseData.count)
            }
    }
    
    
    

}

#Preview {
    ContentView()
}
