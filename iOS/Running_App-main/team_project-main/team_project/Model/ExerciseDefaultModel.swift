//
//  ExerciseModel.swift
//  team_project
//
//  Created by Taewon Yoon on 10/31/23.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class ExerciseRoutineContainer: Identifiable { // 운동 루틴이 저장되는 곳
    var id: UUID = UUID()
    var routineName: String = ""

    // CloudKit과의 호환성을 위해 관계를 선택적으로 변경합니다.
    @Relationship(deleteRule: .cascade, inverse: \ExerciseDefaultModel.exerciseRoutineContainer)
    var exerciseDefaultModel: [ExerciseDefaultModel]? = nil // 선택적으로 변경

    init(id: UUID? = nil, routineName: String, exerciseDefaultModel: [ExerciseDefaultModel]?) {
        self.id = id ?? UUID()
        self.routineName = routineName
        self.exerciseDefaultModel = exerciseDefaultModel
        print("ExerciseRoutineContainer 초기화")
    }
}


@Model
class ExerciseDefaultModel: Identifiable, Hashable {
    var exerciseRoutineContainer: ExerciseRoutineContainer?
    var id = UUID()
    var exerciseName: String = ""
    var part: [ExercisePart] = []
    var tool: ExerciseTool = ExerciseTool.machine
    var set: Int = 0
    var count: [Int] = []
    var kg: [Int] = []
    var done: [Bool] = []
    
    init(exerciseRoutineContainer: ExerciseRoutineContainer? = nil, exerciseName: String, part: [ExercisePart], tool: ExerciseTool) {
        self.exerciseRoutineContainer = exerciseRoutineContainer
        self.id = UUID()
        self.exerciseName = exerciseName
        self.part = part
        self.tool = tool
        self.set = 5
        self.count = [0,0,0,0,0]
        self.kg = [0,0,0,0,0]
        self.done = [false,false,false,false,false]
        print("ExerciseModel 초기화:")
    }
}


@Model
class ExerciseRecordContainer: Identifiable, Hashable {
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    var totalTime: Int = 0
    var routineName: String = ""
    
//    @Relationship(deleteRule: .cascade, inverse: \ExerciseRecordModel.recordContainer)
    var exerciseRecordModel: [ExerciseRecordModel] = []
    
    init(startDate: Date, endDate: Date, totalTime: Int, routineName: String, exerciseRecordModel: [ExerciseRecordModel]) {
        self.startDate = startDate
        self.endDate = endDate
        self.totalTime = totalTime
        self.routineName = routineName
        self.exerciseRecordModel = exerciseRecordModel
    }
}

class ExerciseRecordModel: Codable, Identifiable {
    var id = UUID()
    var exerciseName: String = ""
    var part: [ExercisePart] = []
    var tool: ExerciseTool = ExerciseTool.machine
    var set: Int = 0
    var count: [Int] = []
    var kg: [Int] = []
    var done: [Bool] = []
    

    init(exerciseName: String, part: [ExercisePart], tool: ExerciseTool, set: Int, count: [Int], kg: [Int], done: [Bool]) {
        self.exerciseName = exerciseName
        self.part = part
        self.tool = tool
        self.set = set
        self.count = count
        self.kg = kg
        self.done = done
    }
}




enum ExercisePart: String, CaseIterable, Codable, Identifiable {
    case wholeBody = "전체"
    case chest = "가슴"
    case back = "등"
    case shoulders = "어깨"
    case triceps = "삼두"
    case biceps = "이두"
    case forearms = "전완"
    case abs = "복근"
    case glutes = "둔근"
    case hamstrings = "햄스트링"
    case quadriceps = "대퇴사두"
    case trapezius = "승모"
    case calves = "종아리"
    var id: String { self.rawValue }
}

enum ExerciseTool: String, CaseIterable, Codable {
    case wholeBody = "전체"
    case bodyWeight = "맨몸"
    case cardio = "유산소"
    case stretching = "스트레칭"
    case dumbbell = "덤벨"
    case barbell = "바벨"
    case smithMachine = "스미스머신"
    case resistanceBand = "벤드"
    case machine = "머신"
    case cable = "케이블"
}


struct ExerciseDataModel: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    
    var exerciseName: String
    var part: [ExercisePart]
    var tool: ExerciseTool
    var checked: Bool = false
}




struct ExerciseData {
    static let lowingmachine = ExerciseDefaultModel(exerciseName: "로잉 머신", part: [.hamstrings, .quadriceps], tool: .machine)
    static let dumbbellDeclineBenchPress = ExerciseDefaultModel(exerciseName: "덤벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellFlatBenchPress = ExerciseDefaultModel(exerciseName: "덤벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellInclineBenchPress = ExerciseDefaultModel(exerciseName: "바벨 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .dumbbell)
    static let barbellDeclineBenchPress = ExerciseDefaultModel(exerciseName: "바벨 디클라인", part: [.chest, .triceps], tool: .barbell)
    static let barbellFlatBenchPress = ExerciseDefaultModel(exerciseName: "바벨 플랫 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let barbellInclineBenchPress = ExerciseDefaultModel(exerciseName: "바벨 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .barbell)
    static let machineInclineBenchPress = ExerciseDefaultModel(exerciseName: "머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .machine)
    static let smithMachineBenchPress = ExerciseDefaultModel(exerciseName: "스미스 머신 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineDeclineBenchPress = ExerciseDefaultModel(exerciseName: "스미스 머신 디클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineInclineBenchPress = ExerciseDefaultModel(exerciseName: "스미스 머신 인클라인 벤치 프레스", part: [.chest, .triceps], tool: .smithMachine)
    static let smithMachineCloseGripBenchPress = ExerciseDefaultModel(exerciseName: "스미스 머신 클로즈 그립 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let machineChestPress = ExerciseDefaultModel(exerciseName: "머신 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let cableChestPress = ExerciseDefaultModel(exerciseName: "케이블 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableInclineChestPress = ExerciseDefaultModel(exerciseName: "케이블 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .cable)
    static let bandChestPress = ExerciseDefaultModel(exerciseName: "밴드 체스트 프레스", part: [.chest, .shoulders], tool: .resistanceBand)
    static let dumbbellDeclineFly = ExerciseDefaultModel(exerciseName: "덤벨 디클라인 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellFly = ExerciseDefaultModel(exerciseName: "덤벨 플라이", part: [.chest], tool: .dumbbell)
    static let dumbbellInclineFly = ExerciseDefaultModel(exerciseName: "덤벨 인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let machineFly = ExerciseDefaultModel(exerciseName: "머신 플라이", part: [.chest], tool: .machine)
    static let benchCableFly = ExerciseDefaultModel(exerciseName: "벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let cableCrossoverFly = ExerciseDefaultModel(exerciseName: "케이블 크로스오버 플라이", part: [.chest, .shoulders], tool: .cable)
    static let inclineBenchCableFly = ExerciseDefaultModel(exerciseName: "인클라인 벤치 케이블 플라이", part: [.chest, .shoulders], tool: .cable)
    static let declinePushup = ExerciseDefaultModel(exerciseName: "디클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let diamondPushup = ExerciseDefaultModel(exerciseName: "다이아몬드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let hinduPushup = ExerciseDefaultModel(exerciseName: "힌두 후시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let inclinePushup = ExerciseDefaultModel(exerciseName: "인클라인 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let kneePushup = ExerciseDefaultModel(exerciseName: "니 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let pikePushup = ExerciseDefaultModel(exerciseName: "파이크 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let pushup = ExerciseDefaultModel(exerciseName: "푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let potationPushup = ExerciseDefaultModel(exerciseName: "포테이션 푸시 업", part: [.chest, .triceps], tool: .bodyWeight)
    static let weightedPushup = ExerciseDefaultModel(exerciseName: "중량 푸시 업", part: [.chest, .shoulders], tool: .machine)
    static let lyingDumbbellPullover = ExerciseDefaultModel(exerciseName: "라잉 덤벨 풀오버", part: [.chest, .triceps], tool: .dumbbell)
    static let dumbbellSquatBenchPress = ExerciseDefaultModel(exerciseName: "덤벨 스쿼즈 벤치 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let plateInclineChestPress = ExerciseDefaultModel(exerciseName: "플레이트 인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateDeclineChestPress = ExerciseDefaultModel(exerciseName: "플레이트 디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateBenchPress = ExerciseDefaultModel(exerciseName: "플레이트 벤치 프레스", part: [.chest, .shoulders], tool: .machine)
    static let plateChestPress = ExerciseDefaultModel(exerciseName: "플레이트 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let archerPushup = ExerciseDefaultModel(exerciseName: "아처 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let widePushup = ExerciseDefaultModel(exerciseName: "와이드 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let chestStretch = ExerciseDefaultModel(exerciseName: "가슴 스트레칭", part: [.chest], tool: .stretching)
    static let wideGripBenchPress = ExerciseDefaultModel(exerciseName: "와이드 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let barbellReverseGripBenchPress = ExerciseDefaultModel(exerciseName: "바벨 리버스 그립 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let isometricBenchPress = ExerciseDefaultModel(exerciseName: "정지 벤치 프레스", part: [.chest, .shoulders], tool: .barbell)
    static let dumbbellInclineSqueezePress = ExerciseDefaultModel(exerciseName: "덤벨 인클라인 스쿼즈 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let diamondPress = ExerciseDefaultModel(exerciseName: "다이아몬드 프레스", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableInclineBenchPress = ExerciseDefaultModel(exerciseName: "케이블 인클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let cableBenchPress = ExerciseDefaultModel(exerciseName: "케이블 벤치 프레스", part: [.chest, .shoulders], tool: .cable)
    static let dumbbellFloorHammerPress = ExerciseDefaultModel(exerciseName: "덤벨 플로어 해머 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let dumbbellFloorChestPress = ExerciseDefaultModel(exerciseName: "덤벨 플로어 체스트 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let declineChestPress = ExerciseDefaultModel(exerciseName: "디클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let inclineChestPress = ExerciseDefaultModel(exerciseName: "인클라인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let lyingBarbellPullover = ExerciseDefaultModel(exerciseName: "라잉 바벨 풀오버", part: [.chest, .back], tool: .barbell)
    static let platePress = ExerciseDefaultModel(exerciseName: "플레이트 프레스", part: [.chest, .triceps], tool: .machine)
    static let cableCrossoverLowFly = ExerciseDefaultModel(exerciseName: "케이블 크로스오버 로우 플라이", part: [.chest, .shoulders], tool: .cable)
    static let compensationPushup = ExerciseDefaultModel(exerciseName: "보수 푸시 업", part: [.chest, .shoulders], tool: .bodyWeight)
    static let cableCrossoverHighFly = ExerciseDefaultModel(exerciseName: "케이블 크로스오버 하이 플라이", part: [.chest, .shoulders], tool: .cable)
    static let landmineChestPress = ExerciseDefaultModel(exerciseName: "랜드마인 체스트 프레스", part: [.chest, .shoulders], tool: .machine)
    static let bandedDumbbellPress = ExerciseDefaultModel(exerciseName: "범델 데벨 프레스", part: [.chest, .shoulders], tool: .dumbbell)
    static let inclineFly = ExerciseDefaultModel(exerciseName: "인클라인 플라이", part: [.chest, .shoulders], tool: .dumbbell)
    static let shoulderFoamRoller = ExerciseDefaultModel(exerciseName: "어깨 폼롤러", part: [.chest, .shoulders], tool: .stretching)
    static let handReleasePushup = ExerciseDefaultModel(exerciseName: "핸드 릴리즈 푸시 업", part: [.chest, .back], tool: .bodyWeight)
    static let cableDeclineBenchPress = ExerciseDefaultModel(exerciseName: "케이블 디클라인 벤치 프레스", part: [.chest, .shoulders], tool: .cable)

    static var allExercies: [ExerciseDefaultModel] {
        get {
            return chestExercises
        }
    }
    
    static let chestExercises = [
        dumbbellDeclineBenchPress,
        dumbbellFlatBenchPress,
        dumbbellInclineBenchPress,
        barbellDeclineBenchPress,
        barbellFlatBenchPress,
        barbellInclineBenchPress,
        machineInclineBenchPress,
        smithMachineBenchPress,
        smithMachineDeclineBenchPress,
        smithMachineInclineBenchPress,
        smithMachineCloseGripBenchPress,
        machineChestPress,
        cableChestPress,
        cableInclineChestPress,
        bandChestPress,
        dumbbellDeclineFly,
        dumbbellFly,
        dumbbellInclineFly,
        machineFly,
        benchCableFly,
        cableCrossoverFly,
        inclineBenchCableFly,
        declinePushup,
        diamondPushup,
        hinduPushup,
        inclinePushup,
        kneePushup,
        pikePushup,
        pushup,
        potationPushup,
        weightedPushup,
        lyingDumbbellPullover,
        dumbbellSquatBenchPress,
        plateInclineChestPress,
        plateDeclineChestPress,
        plateBenchPress,
        plateChestPress,
        archerPushup,
        widePushup,
        chestStretch,
        wideGripBenchPress,
        barbellReverseGripBenchPress,
        isometricBenchPress,
        dumbbellInclineSqueezePress,
        diamondPress,
        cableInclineBenchPress,
        cableBenchPress,
        dumbbellFloorHammerPress,
        dumbbellFloorChestPress,
        declineChestPress,
        inclineChestPress,
        lyingBarbellPullover,
        platePress,
        cableCrossoverLowFly,
        compensationPushup,
        cableCrossoverHighFly,
        landmineChestPress,
        bandedDumbbellPress,
        inclineFly,
        shoulderFoamRoller,
        handReleasePushup,
        cableDeclineBenchPress
    ]

}





/*
머신 인클라인 벤치 프레스 (가슴, 삼두)
머신 인클라인 벤치 프레스(가슴, 삼두)
 스미스 머신 벤치 프레스(가슴, 삼두)
 스미스 머신 디클라인 벤치 프레스(가슴,삼두)
 스미스 머신 인클라인 벤치 프레스(가슴, 삼두)
 머신 체스트 프레스(가슴, 어깨)
 케이블 체스트 프레스(가슴, 어깨)
 케이블 인클라인 체스트 프레스(가슴, 어깨)
 밴드 체스트 프레스(가슴, 어깨)
 덤벨 디클라인 플라이(가슴)
 덤벨 플라이(가슴)
 덤벨 인클라인 플라이(가슴, 어깨)
 머신 플라이(팩 덱 플라이) (가슴)
 벤치 케이블 플라이 (가슴, 어깨)
 케이블 크로스오버 플라이 (가슴, 어꺠)
 인클라인 벤치 케이블 플라이(가슴, 어꺠)
 디클라인 푸시 업(가슴, 어깨)
 다이아몬드 푸시 업(가슴, 어깨)
 힌두 후시 업(가슴, 어꺠)
 인클라인 푸시 업(가슴, 어꺠)
 니 푸시 업(가슴, 삼두)
 파이크 푸시 업(가슴,어꺠)
 푸시 업(가슴, 어깨)
 포테이션 푸시 업(가슴, 삼두)
 중량 푸시 업(가슴, 어깨)
 라잉 덤벨 풀오버(가슴, 삼두)
 덤벨 스쿼즈 벤치 프레스(가슴, 어깨)
 플레이트 인클라인 체스트 프레스(가슴, 어꺠)
 플레이트 디클라인 체스트 프레스(가슴, 어깨)
 플레이트 벤치 프레스(가슴, 어깨)
 플레이트 체스트 프레스(가슴, 어깨)
 아처 푸시 업(가슴, 어깨)
 와이드 푸시 업(가슴, 어꺠)
 무릎 대고 푸시 업(가슴, 어꺠)
 가슴 스트레칭(가슴)
 와이드 그립 벤치 프레스(가슴, 어꺠)
 스미스 머신 클로즈 그립 벤치 프레스(가슴, 어꺠)
 바벨 리버스 그립 벤치 프레스(가슴, 어꺠)
 정지 벤치 프레스(가슴, 어깨)
 덤벨 인클라인 스쿼즈 프레스(가슴, 어꺠)
 다이아몬드 프레스(가슴, 어깨)
 케이블 인클라인 벤치 프레스(가슴, 어꺠)
 케이블 벤치 프레스(가슴, 어꺠)
 덤벨 플로어 해머 프레스 (가슴, 어꺠)
 덤벨 플로어 체스트 프레스 (가슴, 어깨)
 디클라인 체스트 프레스(가슴, 어꺠)
 인클라인 체스트 프레스(가슴, 어꺠)
 라잉 바벨 풀오버(가슴, 등)
 플레이트 프레스(가슴, 삼두)
 케이블 크로스오버 로우 플라이(가슴, 어깨)
 보수 푸시 업(가슴, 어꺠)
 케이블 크로스오버 하이 플라이(가슴, 어꺠)
 랜드마인 체스트 프레스(가슴, 어깨)
 범델 데벨 프레스(가슴, 어깨)
 인클라인 플라이(가슴, 어꺠)
 어깨 폼롤러 (가슴, 어깨)
 핸드 릴리즈 푸시 업(가슴, 등)
 케이블 디클라인 벤치 프레스(가슴, 어깨)
 
 
 */
