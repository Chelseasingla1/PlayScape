//
//  CommunityManager.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 13/12/24.
//

import Foundation


// MARK: - Community Manager
class CommunityManager {
    // Singleton pattern setup
    static let shared = CommunityManager()
        
    // Private arrays to store data
    private var chats: [Chat] = []     // Stores all chat conversations
    private var friends: [Friend] = []  // Stores all friendships
    private var groups: [Group] = []    // Stores all groups
        
    private init() {}  // Private initializer for singleton

    
    // MARK: - Friend Management
    // Send a friend request
    func sendFriendRequest(to userId: Int) -> Bool {
        // Check if there's a logged in user
        guard let currentUser = UserDataModel.shared.getCurrentUser() else {
            return false
        }
        
        // Create new friend relationship
        let newFriend = Friend(
            userId: userId,         // ID of user receiving request
            status: .pending,       // Initial status is pending
            since: Date(),         // Current timestamp
            commonInterests: [],    // Start with empty interests
            gamesPlayedTogether: 0  // No games played yet
        )
        
        friends.append(newFriend)  // Add to friends array
        return true
    }

    // Accept a friend request
    func acceptFriendRequest(from userId: Int) -> Bool {
        // Find friend in array
        if let index = friends.firstIndex(where: { $0.userId == userId }) {
            friends[index].status = .accepted  // Update status to accepted
            return true
        }
        return false
    }

    // Get list of accepted friends
    func getFriendsList() -> [Friend] {
        return friends.filter { $0.status == .accepted }
    }
    
    // MARK: - Chat Management
    // Send a message to a user
    func sendMessage(to userId: Int, content: String) -> Bool {
        // Check if there's a logged in user
        guard let currentUser = UserDataModel.shared.getCurrentUser() else {
            return false
        }
        
        // Create new message
        let message = Message(
            id: Int.random(in: 1...10000),  // Random ID for message
            senderId: currentUser.id,        // Current user is sender
            content: content,                // Message content
            timestamp: Date(),               // Current time
            messageType: .text,              // Type is text
            isRead: false                    // Initially unread
        )
        
        // Find existing chat with user
        if let chatIndex = chats.firstIndex(where: { chat in
            chat.participants.contains(where: { $0.id == userId })
        }) {
            // Update existing chat with new message
            var updatedChat = chats[chatIndex]
            updatedChat.messages.append(message)
            chats[chatIndex] = updatedChat
            return true
        }
        
        return false
    }

    // Get unread messages from a specific user
    func getUnreadMessages(for userId: Int) -> [Message] {
        // Find chat with user
        guard let chat = chats.first(where: { chat in
            chat.participants.contains(where: { $0.id == userId })
        }) else {
            return []
        }
        
        // Return only unread messages
        return chat.messages.filter { !$0.isRead }
    }
    
    // Create a new group
    func createGroup(name: String, sport: Sport, skillLevel: SkillLevel) -> Group? {
        // Check if there's a logged in user
        guard let currentUser = UserDataModel.shared.getCurrentUser() else {
            return nil
        }
        
        // Create new group
        let newGroup = Group(
            id: groups.count + 1,
            name: name,
            description: "Sport group for \(sport.rawValue)",
            sport: sport,
            skillLevel: skillLevel,
            members: [currentUser],    // Creator is first member
            admins: [currentUser],     // Creator is first admin
            messages: [],              // Empty message list
            createdAt: Date(),
            upcomingGames: []          // No games yet
        )
        
        groups.append(newGroup)
        return newGroup
    }

    // Join an existing group
    func joinGroup(groupId: Int) -> Bool {
        // Get current user and find group
        guard let currentUser = UserDataModel.shared.getCurrentUser(),
              let groupIndex = groups.firstIndex(where: { $0.id == groupId }) else {
            return false
        }
        
        // Add user to group members
        var group = groups[groupIndex]
        group.members.append(currentUser)
        groups[groupIndex] = group
        return true
    }

    // Get groups for a specific sport
    func getGroupsByInterest(sport: Sport) -> [Group] {
        return groups.filter { $0.sport == sport }
    }

    // Add a game to a group
    func addGameToGroup(groupId: Int, game: Game) -> Bool {
        // Find group
        guard let groupIndex = groups.firstIndex(where: { $0.id == groupId }) else {
            return false
        }
        
        // Add game to group's upcoming games
        var group = groups[groupIndex]
        group.upcomingGames.append(game)
        groups[groupIndex] = group
        return true
    }
}
