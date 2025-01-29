//
//  SharedEnums.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

enum Sport: String,Codable {
    case football = "Football"
    case basketball = "Basketball"
    case cricket = "Cricket"
    case volleyball = "Volleyball"
    case tableTennis = "Table Tennis"
    case badminton = "Badminton"
    
    var defaultDuration: Int {
        switch self {
        case .football: return 60
        case .basketball: return 45
        case .cricket: return 120
        case .volleyball: return 45
        case .tableTennis: return 30
        case .badminton: return 30
        }
    }
}

enum SkillLevel: String,Codable {
    case beginner = "Beginner"
    case amateur = "Amateur"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case professional = "Professional"
}

enum GameAccessType :Codable{
    case Public
    case inviteOnly
}

enum MessageType: String, Codable {
    case text
    case image
    case gameInvite
    case groupInvite
}

enum FriendshipStatus: String,Codable {
    case pending
    case accepted
    case blocked
}
