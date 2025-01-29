//
//  GameManager.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

// MARK: - GameManager Class
/// Manages game creation, scheduling, and retrieval
/// Uses singleton pattern to maintain consistent game state across the app
class GameManager {
   // MARK: Properties
   
   /// Array to store all created games
   private var games: [Game] = []
   
   /// Shared instance for singleton pattern implementation
   static let shared = GameManager()
   
   /// Private initializer to enforce singleton pattern
   private init() {}
   
   // MARK: Game Management Methods
   
   /// Creates a new game session with court reservation
   /// - Parameters:
   ///   - title: Name/title of the game session
   ///   - sport: Type of sport for the game
   ///   - startTime: When the game session starts
   ///   - organizer: User creating the game
   ///   - skillLevel: Required skill level for participants
   ///   - accessType: Whether game is public or invite-only
   ///   - maxParticipants: Maximum number of players allowed
   /// - Returns: Optional Game object. nil if creation fails (e.g., no courts available)
   func createGame(title: String,
                  sport: Sport,
                  startTime: Date,
                  organizer: UserData,
                  skillLevel: SkillLevel,
                  accessType: GameAccessType,
                  maxParticipants: Int) -> Game? {
       
       // Calculate game end time based on sport's default duration
       let endTime = startTime.addingTimeInterval(TimeInterval(sport.defaultDuration * 60))
       
       // Find available courts for the time slot
       let availableCourts = ResourceManager.shared.getAvailableCourts(
           sport: sport,
           startTime: startTime,
           endTime: endTime
       )
       
       // Ensure at least one court is available
       guard let court = availableCourts.first else {
           return nil  // No courts available
       }
       
       // Generate new game ID
       let gameId = games.count + 1
       
       // Try to reserve the court
       guard ResourceManager.shared.reserveCourt(
           courtId: court.id,
           startTime: startTime,
           endTime: endTime,
           gameId: gameId
       ) else {
           return nil  // Court reservation failed
       }
       
       // Create new game instance
       let newGame = Game(
           id: gameId,
           title: title,
           sport: sport,
           startTime: startTime,
           endTime: endTime,
           court: court,
           skillLevel: skillLevel,
           accessType: accessType,
           maxParticipants: maxParticipants,
           organizer: organizer,
           participants: [organizer],  // Organizer automatically joins
           rules: ["Respect", "Be good", "Stay safe"],
           createdAt: Date()
       )
       
       // Add to games array and return
       games.append(newGame)
       return newGame
   }
   
   /// Finds all available time slots for a sport on a given date
   /// - Parameters:
   ///   - sport: Type of sport
   ///   - date: Date to check availability
   /// - Returns: Array of Date objects representing available start times
   func getAvailableTimeSlots(sport: Sport, date: Date) -> [Date] {
       let calendar = Calendar.current
       var availableSlots: [Date] = []
       
       // Set university facility hours (6 AM to 10 PM)
       guard let dayStart = calendar.date(
           bySettingHour: 6, minute: 0, second: 0, of: date),
             let dayEnd = calendar.date(
               bySettingHour: 22, minute: 0, second: 0, of: date) else {
           return []
       }
       
       // Check availability in 30-minute increments
       var currentTime = dayStart
       while currentTime < dayEnd {
           // Calculate end time for current slot
           let slotEndTime = currentTime.addingTimeInterval(
               TimeInterval(sport.defaultDuration * 60)
           )
           
           // Check court availability
           let availableCourts = ResourceManager.shared.getAvailableCourts(
               sport: sport,
               startTime: currentTime,
               endTime: slotEndTime
           )
           
           // If courts available, add time slot
           if !availableCourts.isEmpty {
               availableSlots.append(currentTime)
           }
           
           // Move to next 30-minute slot
           currentTime = calendar.date(byAdding: .minute, value: 30, to: currentTime) ?? dayEnd
       }
       
       return availableSlots
   }
   
   /// Retrieves all games scheduled for a specific date
   /// - Parameter date: Date to check for games
   /// - Returns: Array of Game objects scheduled for that date
   func getGamesForDate(_ date: Date) -> [Game] {
       let calendar = Calendar.current
       return games.filter { game in
           calendar.isDate(game.startTime, inSameDayAs: date)
       }
   }
}

// MARK: - Usage Examples
/*
// Example 1: Create a new game
let newGame = GameManager.shared.createGame(
   title: "Evening Basketball",
   sport: .basketball,
   startTime: Date(),
   organizer: currentUser,
   skillLevel: .beginner,
   accessType: .public,
   maxParticipants: 10
)

// Example 2: Check available slots for tomorrow
let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
let availableSlots = GameManager.shared.getAvailableTimeSlots(
   sport: .basketball,
   date: tomorrow
)

// Example 3: Get all games for today
let todaysGames = GameManager.shared.getGamesForDate(Date())
*/
