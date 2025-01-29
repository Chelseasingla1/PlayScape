//
//  comunity.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 13/12/24.
//

import Foundation

struct Group {
    let id: Int
    var name: String
    var description: String
    var sport: Sport
    var skillLevel: SkillLevel
    var members: [UserData]
    var admins: [UserData]
    var messages: [Message]
    let createdAt: Date
    var upcomingGames: [Game]
    
    var memberCount: Int {
        members.count
    }
}
