//
//  ContentView.swift
//  team_project
//
//  Created by Taewon Yoon on 10/26/23.
//

import SwiftUI
import SwiftData
import CodeScanner

struct ContentView: View {
    @State private var appear = false
    @Environment(\.dismiss) var dismiss
    @Environment(NavigationObject.self) private var path
    @Environment(TimerManager.self) var timer
    @State var tab = 1
    @State private var tabSelection: TabBarItem = .home
    @State private var fullScreen: Bool = false
//    @State var recordContainer: ExerciseRecordContainer?
    @State private var showAlert: Bool = false
    
    
    // MARK: - FUNCTIONS
    
    var body: some View {
        @Bindable var path = path
        NavigationStack(path: $path.path) {
            CustomTabBarContainerView(selection: $tabSelection, content: {
                MainViewContainer()
                    .tabBarItem(tab: .home, selection: $tabSelection)
                
                RecordViewContainer()
                    .tabBarItem(tab: .calendar, selection: $tabSelection)
                
                ProfileView()
                    .tabBarItem(tab: .profile, selection: $tabSelection)
            })
            .overlay {
                if timer.showAlert {
                    ExerciseAlertView()
                }
            } //OVERLAY
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        fullScreen.toggle()
                    } label: {
                        Image(systemName: "qrcode.viewfinder")
                            .foregroundStyle(Color.white)
                    }
                    
                }
                switch tabSelection {
                case .home:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("홈")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                case .calendar:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("기록")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                case .profile:
                    ToolbarItem(placement: .topBarLeading) {
                        Text("내 라이브러리")
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            SettingView()
                        } label: {
                            Image(systemName: "gear")
                        }
                        
                    }
                }
            } //TOOLBAR
            .overlay(alignment: .bottom, content: {
//                VStack {
//                    if timer.showTimer {
//                        NavigationLink {
//                            if let data = timer.exerciseRoutineContainer {
//                                RoutineListView(exerciseContainer: data)
//                            }
//                        } label: {
//                            if let data = timer.exerciseRoutineContainer {
//                                TimerView(exerciseContainer: data)
//                            }
//                        }
//                    }
//                }
            }) //OVERLAY
            .padding()
            
            .onAppear {
                path.tab = false
            }
            .fullScreenCover(isPresented: $fullScreen, onDismiss: {

            },content: {
                QRScannerView(showAlert: $showAlert)
            })
            .alert("유효하지 않은 QR 코드입니다", isPresented: $showAlert) {
                Button("확인", role: .cancel) {}
            } message: {
                Text("다시 QR를 찍어주세요")
            }
        } //NavigationStack
        .ignoresSafeArea(edges: .bottom)


        
    }
}

struct ContentScreen: View {
    
    var body: some View {
        NavigationStack {
            
            ContentView()
            
        }
    }
}

#Preview { @MainActor in
    ContentScreen()
        .modelContainer(previewRoutineContainer)
        .modelContainer(previewRecordContainer)
        .environment(TimerManager())
        .environmentObject(NavigationObject())
}

/*
 
 //            TabView(selection: $tab){
 //
 //                MainViewContainer()
 //                    .tag(1)
 //
 //                RecordViewContainer()
 //                    .tag(2)
 //
 //                ProfileView()
 //                    .tag(3)
 //            }
 
 
 //                    Color(uiColor: UIColor.darkBlack)
 //                        .opacity(path.tab ? 0 : 1)
 //                        .ignoresSafeArea(edges: .vertical)
 //                        .frame(height: 50)
 //                        .overlay(HStack {
 //                            Spacer()
 //
 //                            Button(action: {
 //                                self.tab = 1
 //                            }, label: {
 //                                Image(systemName: "house.fill")
 //                                    .resizable()
 //                                    .aspectRatio(contentMode: .fit)
 //                                    .frame(width: 25, height: 25)
 //                                    .opacity(tab == 1 ? 1 : 0.4)
 //                                    .foregroundStyle(.white)
 //                                    .opacity(path.tab ? 0 : 1)
 //                            })
 //
 //                            Spacer()
 //
 //                            Button(action: {
 //                                self.tab = 2
 //                            }, label: {
 //                                Image(systemName: "calendar")
 //                                    .resizable()
 //                                    .aspectRatio(contentMode: .fit)
 //                                    .frame(width: 25, height: 25)
 //                                    .opacity(tab == 2 ? 1 : 0.4)
 //                                    .foregroundStyle(.white)
 //                                    .opacity(path.tab ? 0 : 1)
 //                            })
 //
 //                            Spacer()
 //
 //                            Button(action: {
 //                                self.tab = 3
 //                            }, label: {
 //                                Image(systemName: "person")
 //                                    .resizable()
 //                                    .aspectRatio(contentMode: .fit)
 //                                    .frame(width: 25, height: 25)
 //                                    .opacity(tab == 3 ? 1 : 0.4)
 //                                    .foregroundStyle(.white)
 //                                    .opacity(path.tab ? 0 : 1)
 //                            })
 //
 //                            Spacer()
 //                        })
 */
