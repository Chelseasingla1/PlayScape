//
//  friends.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 13/12/24.
//

import Foundation

struct Friend {
    let userId: Int
    var status: FriendshipStatus
    let since: Date
    var commonInterests: [Sport]
    var gamesPlayedTogether: Int
}
