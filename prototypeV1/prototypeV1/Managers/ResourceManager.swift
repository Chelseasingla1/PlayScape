//
//  ResourceManager.swift
//  prototypeV1
//
//  Created by Shravan Rajput on 12/12/24.
//

import Foundation

// MARK: - ResourceManager Class
/// Manages sports facility resources including courts and time slots
/// Uses singleton pattern to ensure consistent resource management across the app
class ResourceManager {
   // MARK: Properties
   
   /// Shared instance for singleton pattern implementation
   static let shared = ResourceManager()
   
   /// Array of all available courts in the university
   private var courts: [Court]
   
   /// Array to track all court reservations/bookings
   private var timeSlots: [TimeSlot] = []
   
   /// Private initializer to enforce singleton pattern
   /// Initializes all available courts in the university
   private init() {
       courts = [
           Court(id: 1, name: "Football Ground", sport: .football),
           Court(id: 2, name: "Basketball Court", sport: .basketball),
           Court(id: 3, name: "Cricket Ground", sport: .cricket),
           Court(id: 4, name: "Badminton Court 1", sport: .badminton),
           Court(id: 5, name: "Badminton Court 2", sport: .badminton),
           Court(id: 6, name: "Table Tennis Room", sport: .tableTennis)
       ]
   }
   
   // MARK: Court Availability Methods
   
   /// Checks if a specific court is available for a given time slot
   /// - Parameters:
   ///   - courtId: Unique identifier of the court
   ///   - startTime: Desired booking start time
   ///   - endTime: Desired booking end time
   /// - Returns: Boolean indicating if court is available (true) or not (false)
   func isCourtAvailable(courtId: Int, startTime: Date, endTime: Date) -> Bool {
       // Iterate through all existing bookings
       for slot in timeSlots {
           // Check bookings for the requested court
           if slot.courtId == courtId {
               // Time slot overlap check:
               // An overlap occurs if the new booking starts before existing booking ends
               // AND ends after existing booking starts
               let hasOverlap = startTime < slot.endTime && endTime > slot.startTime
               
               // If overlap found, court is not available
               if hasOverlap {
                   return false
               }
           }
       }
       
       // No overlapping bookings found, court is available
       return true
   }
   
   /// Attempts to reserve a court for a specific time slot
   /// - Parameters:
   ///   - courtId: Unique identifier of the court to reserve
   ///   - startTime: Booking start time
   ///   - endTime: Booking end time
   ///   - gameId: Unique identifier of the game for which court is being reserved
   /// - Returns: Boolean indicating successful reservation (true) or failure (false)
   func reserveCourt(courtId: Int, startTime: Date, endTime: Date, gameId: Int) -> Bool {
       // First verify court is available
       guard isCourtAvailable(courtId: courtId, startTime: startTime, endTime: endTime) else {
           return false
       }
       
       // Create new booking time slot
       let newSlot = TimeSlot(
           startTime: startTime,
           endTime: endTime,
           courtId: courtId,
           gameId: gameId
       )
       
       // Add booking to system
       timeSlots.append(newSlot)
       return true
   }
   
   /// Retrieves all available courts for a specific sport and time slot
   /// - Parameters:
   ///   - sport: Type of sport (e.g., basketball, football)
   ///   - startTime: Desired booking start time
   ///   - endTime: Desired booking end time
   /// - Returns: Array of Court objects that are available for booking
   func getAvailableCourts(sport: Sport, startTime: Date, endTime: Date) -> [Court] {
       return courts.filter { court in
           // Return courts that match the sport and are available for the time slot
           court.sport == sport &&
           isCourtAvailable(courtId: court.id, startTime: startTime, endTime: endTime)
       }
   }
}

// MARK: - Usage Examples
/*
// Initialize resource manager
let resourceManager = ResourceManager.shared

// Example 1: Check court availability for evening slot
let calendar = Calendar.current
let today7PM = calendar.date(bySettingHour: 19, minute: 0, second: 0, of: Date())!
let today8PM = calendar.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!

// Find available basketball courts
let availableCourts = resourceManager.getAvailableCourts(
   sport: .basketball,
   startTime: today7PM,
   endTime: today8PM
)

// Example 2: Reserve an available court
if let court = availableCourts.first {
   let booked = resourceManager.reserveCourt(
       courtId: court.id,
       startTime: today7PM,
       endTime: today8PM,
       gameId: 1
   )
   
   if booked {
       print("Basketball court reserved!")
   }
}

// Example 3: Check specific court availability
let isAvailable = resourceManager.isCourtAvailable(
   courtId: 2,  // Basketball court
   startTime: today7PM,
   endTime: today8PM
)
*/
