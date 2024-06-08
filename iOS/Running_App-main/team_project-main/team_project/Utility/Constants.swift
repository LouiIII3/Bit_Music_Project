//
//  Constants.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation

struct Constants {
    private static let baseUrlPath = "http://lsproject.shop:8080"
    
    
    var requestEmailCode = URL(string: baseUrlPath + "/mailConfirm")
    var verifyEmailCode = URL(string: baseUrlPath + "/verifyCode")
    var registerPath = URL(string: baseUrlPath + "/join")
    
    var loginPath = URL(string: baseUrlPath + "/login")
    var changePasswordPath = URL(string: baseUrlPath + "/changePassword")
    
    var exercise = URL(string: baseUrlPath + "/exercise/user-data")
    var getAllMusic = URL(string: baseUrlPath + "/all")
    var currentmusic = URL(string: baseUrlPath + "/music")
    var previousmusic = URL(string: baseUrlPath + "/previous")
    var nextmusic = URL(string: baseUrlPath + "/next")
    var getOneMusic = URL(string: baseUrlPath + "/music/") // 뒤에 아이디 붙여줄것
}


let dateformat: DateFormatter = {
      let formatter = DateFormatter()
       formatter.dateFormat = "YYYY년 M월 d일"
       return formatter
}()

let startTimeFormat: DateFormatter = {
      let formatter = DateFormatter()
       formatter.dateFormat = "YYYY-MM-dd hh:mm"
       return formatter
}()

let endTimeFormat: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "hh:mm"
    return formatter
}()
