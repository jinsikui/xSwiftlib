//
//  LearntWordSwift.swift
//  xSwiftlib
//
//  Created by pwrd on 2023/5/1.
//


import Foundation
import UIKit
import WCDBSwift


final class LearntWordSwift: WordBase, TableCodable {
    
    var aid: Int = 0
    var addDate: Date?
    var updateDate: Date?
    var belongId: String?
    var belongType: WordBelong = .mastered
    var knowLastDate: Date?
    var knowNextDate: Date?
    var dm: CGFloat = 0.0
    var mode: AbilityMode = .single
    var wrongTimes: Int = 0
    var knowWrongTimes: Int = 0
    var listenWrongTimes: Int = 0
    var speakWrongTimes: Int = 0
    var abilityOption: AbilityOption = []
    var reviewWrongTimes: Int = 0
    var reviewAnswerTimes: Int = 0
    var memoryScore: CGFloat = 0.0
    var examStatus: Int = 0
    var examCompleted: Bool = false
    var masterOption: MasterMarkOption = []
    var isCurrentRound: Bool = false
    var firstSubjectiveResult: SubjectiveResult = .none
    var preciseReviewState: PreciseReviewExamState = .firstSubjectiveExam
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = LearntWordSwift
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case wordId
        case aid
    }
    
    override init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.aid = try container.decode(Int.self, forKey: .aid)
        self.wordId = try container.decode(Int.self, forKey: .wordId)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.aid, forKey: .aid)
        try container.encode(self.wordId, forKey: .wordId)
        
    }
    
    
}
