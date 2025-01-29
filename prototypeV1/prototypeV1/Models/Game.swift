//
//  Game.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

struct Game {
    let id: Int
    var title: String
    var sport: Sport
    var startTime: Date
    var endTime: Date
    var court: Court
    var skillLevel: SkillLevel
    var accessType: GameAccessType
    var maxParticipants: Int
    var organizer: UserData
    var participants: [UserData]
    var rules: [String]
    var createdAt: Date
    
    var isFull: Bool {
        return participants.count >= maxParticipants
    }
}
