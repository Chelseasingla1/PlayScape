//
//  GameData.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 20/01/25.
//

import Foundation

struct GameData: Identifiable {
    let id: Int
    var personName: String
    var personImage: String
    var going: String
    var mutual: String
    var gameType: String
    var gameIcon: String
    var date: String?
    var location: String?
    var time: String?
    var isCompleted: Bool
    
    // Static factory method for creating new games
    static func createNew(sport: String, area: String, date: String, time: String) -> GameData {
        return GameData(
            id: Int.random(in: 1...1000),
            personName: "Created by You",
            personImage: "person.circle.fill",
            going: "1 Going",
            mutual: "0 Mutual",
            gameType: sport,
            gameIcon: "figure.\(sport.lowercased())",
            date: date,
            location: area,
            time: time,
            isCompleted: false
        )
    }
    
    // Default initializer
    init(id: Int, personName: String, personImage: String, going: String, mutual: String,
         gameType: String, gameIcon: String, date: String?, location: String?, time: String?,
         isCompleted: Bool = false) {
        self.id = id
        self.personName = personName
        self.personImage = personImage
        self.going = going
        self.mutual = mutual
        self.gameType = gameType
        self.gameIcon = gameIcon
        self.date = date
        self.location = location
        self.time = time
        self.isCompleted = isCompleted
    }
}

class GameDataManager {
    static let shared = GameDataManager()
    
    private var games: [GameData] = []
    
    private init() {
        // Initialize with sample data
        games = [
            GameData(
                id: 1,
                personName: "Aseem Bhardwaj",
                personImage: "person1",
                going: "5 Going",
                mutual: "2 Mutual",
                gameType: "Boxing",
                gameIcon: "figure.boxing",
                date: "26 Dec, Night",
                location: "Court 1, Chitkara university",
                time: "10:00 PM",
                isCompleted: false
            ),
            GameData(
                id: 2,
                personName: "Aseem Bhardwaj",
                personImage: "person1",
                going: "5 Going",
                mutual: "2 Mutual",
                gameType: "Badminton",
                gameIcon: "figure.badminton",
                date: "26 Dec, Night",
                location: "Court 1, Chitkara university",
                time: "10:00 PM",
                isCompleted: false
            )
        ]
    }
    
    // MARK: - Data Access Methods
    func getAllGames() -> [GameData] {
        return games
    }
    
    func getGamesOfType(_ type: String) -> [GameData] {
        return games.filter { $0.gameType == type }
    }
    
    func addGame(_ game: GameData) {
        games.append(game)
    }
    
    func updateGame(_ game: GameData) {
        if let index = games.firstIndex(where: { $0.id == game.id }) {
            games[index] = game
        }
    }
    
    func deleteGame(id: Int) {
        games.removeAll { $0.id == id }
    }
    
    func toggleGameCompletion(id: Int) {
        if let index = games.firstIndex(where: { $0.id == id }) {
            games[index].isCompleted.toggle()
        }
    }
}
