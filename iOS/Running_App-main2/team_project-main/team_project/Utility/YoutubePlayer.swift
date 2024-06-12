////
////  YoutubePlayerModel.swift
////  team_project
////
////  Created by Taewon Yoon on 3/28/24.
////
//
//import Alamofire
//import SwiftUI
//
//@Observable class YoutubePlayer {
//   init() {
//      Task(priority: .high) {
//        loadJSON()
//      }
//   }
//   func loadJSON() {
//      let session = URLSession.shared
//      let webURL = URL(string: "https://jsonplaceholder.typicode.com/posts")
//
//       AF.request(webURL!,
//                  method: .get).response { data in
//           print(data)
//       }
//   }
//}
//
//struct testing: View {
//    @State var player: YoutubePlayer
//    var body: some View {
//        Button(action: {
//            player.loadJSON()
//        }, label: {
//            Text("Button")
//        })
//    }
//}
//
//#Preview {
//    testing(player: YoutubePlayer())
//}
