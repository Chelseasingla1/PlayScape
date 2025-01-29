//
//  User.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

struct SportInterest: Codable {
    var sport: Sport
    var skillLevel: SkillLevel
}

struct UserData: Codable {
    var id: Int
    var name: String
    var email: String
    var password : String
    var dateOfBirth: String
    var university: String
    var sports: [SportInterest]
    var profileImage: String
}

