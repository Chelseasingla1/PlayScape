//
//  chat.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 13/12/24.
//

import Foundation

struct Message: Codable {
    let id: Int
    let senderId: Int
    let content: String
    let timestamp: Date
    let messageType: MessageType
    var isRead: Bool
}

struct Chat {
    let id: Int
    let participants: [UserData]
    var messages: [Message]
    let createdAt: Date
    var lastMessageTimestamp: Date
    
    var unreadCount: Int {
        messages.filter { !$0.isRead }.count
    }
}
