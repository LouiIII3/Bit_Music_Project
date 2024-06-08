//
//  StartingTimerView.swift
//  team_project_w Watch App
//
//  Created by Taewon Yoon on 5/6/24.
//

import SwiftUI

struct StartingTimerView: View {
    @EnvironmentObject var workoutManager: WorkoutManager

    @State var percent: CGFloat = 0
    @State var count: String = ""
    @Binding var finished: Bool
    
    var body: some View {
        Loader(percent: $percent, count: $count)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 0.33
                        count = "1"
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 0.66
                        count = "2"
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        percent = 1
                        count = "3"
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.4) {
                    count = "시작!"
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    finished = true
                    workoutManager.selectedWorkout = .traditionalStrengthTraining
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StartingTimerView(finished: .constant(false))
        .environmentObject(WorkoutManager())
        .environmentObject(WatchToiOS())
        .modelContainer(previewRoutineContainer)
}

struct Loader: View {
    
    @Binding var percent: CGFloat
    @Binding var count: String
    
    var colors: [Color] = [
        Color(hex: "#AAFFA9"),
        Color(hex: "#11FFBD")
    ]
    
    let circleHeight: CGFloat = 140
     
    var body: some View {
        let completion = percent
        Circle()
            .trim(from: 0, to: completion)
            .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .butt, lineJoin: .bevel, miterLimit: 50))
            .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
            .rotationEffect(.degrees(-90))
            .frame(width: circleHeight, height: circleHeight)
            .overlay(
                Text(String(count))
                    .font(.system(size: 40))
                    .bold()
            )
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 22, lineCap: .butt, lineJoin: .bevel, miterLimit: 50))
                    .fill(Color.gray.opacity(0.1))
            }
    }
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}

/*
 struct CountdownView: View {
   @Binding var countdown: CGFloat

   var body: some View {
     ZStack {
       Text("\(String(format: "%.0f", min(3, ceil(countdown + 0.01))))")
         .font(Font.system(.largeTitle).monospacedDigit())
         .foregroundColor(Color(.white))
       Circle()
         .stroke(lineWidth: 15)
         .foregroundColor(Color(.darkGray))
         .padding(10)
       Circle()
         .trim(from: 0, to: countdown / 3.0)
         .stroke(style: StrokeStyle(lineWidth: 13, lineCap: .round, lineJoin: .round))
         .rotation(Angle(degrees: 90))
         .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
         .foregroundColor(Color(.green))
         .padding(10)
     }
     .frame(maxWidth: .infinity, maxHeight: .infinity)
     .background(Color(.black))
   }
 }

 struct AnimatedCountdownView: View {
   @State var countdown: CGFloat = 3

   let timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common)
     .autoconnect()
     .prefix(3)

   var body: some View {
     CountdownView(countdown: $countdown)
       .onReceive(timer) { _ in
         withAnimation(.linear(duration: 1.0)) {
           countdown -= 1.0
         }
       }
   }
 }

 #Preview {
     
 }
 */
