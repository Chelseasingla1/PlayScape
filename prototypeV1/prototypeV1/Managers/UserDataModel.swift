//
//  UserDataModel.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

// MARK: - Sample User Data
/// Sample user instance for testing and initial setup
let firstUser = UserData(
    id: 1,
    name: "Alex Garrison",
    email: "alex.garrison@gmail.com",
    password: "Alex@2345",
    dateOfBirth: "Sep 22, 2002",
    university: "Chitkara University",
    sports: [
        SportInterest(sport: .cricket, skillLevel: .beginner),
        SportInterest(sport: .football, skillLevel: .beginner)
    ],
    profileImage: "profile_default.jpeg"
)


// MARK: - UserDataModel Class
/// Manages user authentication, sports interests, and user data storage
/// Uses singleton pattern to ensure single source of truth for user data
class UserDataModel {
    // MARK: Properties
    private var users: [UserData] = [] {
        didSet {
            saveUsers() // Save whenever users array changes
        }
    }
    
    private var currentUser: UserData? {
        didSet {
            saveCurrentUser() // Save whenever current user changes
        }
    }
    
    static var shared: UserDataModel = UserDataModel()
    
    private init() {
        loadUsers()        // Load saved users when initializing
        loadCurrentUser()  // Load saved current user
        
        // Add first user if no users exist
        if users.isEmpty {
            users = [firstUser]
        }
    }
    
    // MARK: UserDefaults Methods
    private func saveUsers() {
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: "savedUsers")
        }
    }
    
    func login(email: String, password: String) -> Bool {
        // Check if account is deleted
        if let deletedEmail = UserDefaults.standard.string(forKey: "deletedAccount"),
           deletedEmail == email {
            return false // Account has been deleted
        }
        
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            currentUser = user
            return true
        }
        return false
    }
    
    private func loadUsers() {
        if let savedUsers = UserDefaults.standard.data(forKey: "savedUsers"),
           let decodedUsers = try? JSONDecoder().decode([UserData].self, from: savedUsers) {
            users = decodedUsers
        }
    }
    
    private func saveCurrentUser() {
        if let encoded = try? JSONEncoder().encode(currentUser) {
            UserDefaults.standard.set(encoded, forKey: "currentUser")
        }
    }
    
    private func loadCurrentUser() {
        if let savedUser = UserDefaults.standard.data(forKey: "currentUser"),
           let decodedUser = try? JSONDecoder().decode(UserData.self, from: savedUser) {
            currentUser = decodedUser
        }
    }
    
    // MARK: Authentication Methods
    func signup(name: String, email: String, password: String, dateOfBirth: String,
                university: String) -> Bool {
        if users.contains(where: { $0.email == email }) {
            return false
        }
        
        let newUser = UserData(
            id: users.count + 1,
            name: name,
            email: email,
            password: password,
            dateOfBirth: dateOfBirth,
            university: university,
            sports: [],
            profileImage: "profile_default.jpeg"
        )
        
        users.append(newUser)
        currentUser = newUser
        return true
    }
    
//    func login(email: String, password: String) -> Bool {
//        if let user = users.first(where: { $0.email == email && $0.password == password }) {
//            currentUser = user
//            return true
//        }
//        return false
//    }
    
    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
    
    // MARK: User Data Methods
    func getCurrentUser() -> UserData? {
        return currentUser
    }
    
    func updateSportsInterests(selectedSport: Sport, skillLevel: SkillLevel) -> Bool {
        guard var currentUser = currentUser else {
            return false
        }
        
        if let index = currentUser.sports.firstIndex(where: { $0.sport == selectedSport }) {
            currentUser.sports[index].skillLevel = skillLevel
        } else {
            let newSportInterest = SportInterest(
                sport: selectedSport,
                skillLevel: skillLevel
            )
            currentUser.sports.append(newSportInterest)
        }
        
        if let userIndex = users.firstIndex(where: { $0.id == currentUser.id }) {
            users[userIndex] = currentUser
            self.currentUser = currentUser
            return true
        }
        
        return false
    }
    
    func removeSportInterest(sport: Sport) -> Bool {
        guard var currentUser = currentUser else {
            return false
        }
        
        currentUser.sports.removeAll { $0.sport == sport }
        
        if let index = users.firstIndex(where: { $0.id == currentUser.id }) {
            users[index] = currentUser
            self.currentUser = currentUser
            return true
        }
        
        return false
    }
    
    func getCurrentUserSports() -> [SportInterest]? {
        return currentUser?.sports
    }
}
// MARK: - Usage Examples
/*
// Signup Example
let signupSuccess = UserDataModel.shared.signup(
    name: "John Doe",
    email: "john@gmail.com",
    password: "John@1234",
    dateOfBirth: "Jan 15, 2003",
    university: "Chitkara University"
)

// Login Example
let loginSuccess = UserDataModel.shared.login(
    email: "john@gmail.com",
    password: "John@1234"
)

// Update Sports Interests Example
if loginSuccess {
    _ = UserDataModel.shared.updateSportsInterests(
        selectedSport: .football,
        skillLevel: .beginner
    )
    
    _ = UserDataModel.shared.updateSportsInterests(
        selectedSport: .cricket,
        skillLevel: .intermediate
    )
}

// Get Current User Sports Example
if let sports = UserDataModel.shared.getCurrentUserSports() {
    for sport in sports {
        print("Sport: \(sport.sport.rawValue), Level: \(sport.skillLevel.rawValue)")
    }
}
*/
