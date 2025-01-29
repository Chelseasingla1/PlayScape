//
//  GameEventsViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 17/01/25.
//

import UIKit

class GameEventsViewController: UIViewController {

    @IBOutlet weak var createGameButton: UIButton!
       @IBOutlet weak var gamesCreatedLabel: UILabel!
       @IBOutlet weak var tableView: UITableView!
       
    var selectedGameType: String?
       var filteredGames: [GameData] = []
    private let gameDataManager = GameDataManager.shared
       
       // MARK: - Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           setupTableView()
           initializeGamesData()
           filterGames()
       }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           filterGames() // Refresh games when view appears
       }
    
    private func setupUI() {
           view.backgroundColor = .black
           navigationItem.title = selectedGameType
           
           createGameButton.setTitle("+ Create Game", for: .normal)
           createGameButton.setTitleColor(.systemBlue, for: .normal)
           
           updateGamesCreatedLabel()
       }
       
       private func setupTableView() {
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = .black
           tableView.separatorStyle = .none
           
           // Register cell if using XIB
           // tableView.register(UINib(nibName: "GameEventTableViewCell", bundle: nil), forCellReuseIdentifier: GameEventTableViewCell.identifier)
       }
    
    private func initializeGamesData() {
           // Initialize sample data if not already present
           let sampleGames = [
               GameData(
                   id: 1,
                   personName: "Hailey Anderson",
                   personImage: "profile1",
                   going: "1 Going",
                   mutual: "2 Mutual",
                   gameType: "Badminton",
                   gameIcon: "figure.badminton",
                   date: "12 Nov, Evening",
                   location: "Court 1, chitkara university",
                   time: "19:00",
                   isCompleted: false
               ),
               GameData(
                   id: 2,
                   personName: "Hola Anderson",
                   personImage: "profile2",
                   going: "1 Going",
                   mutual: "3 Mutual",
                   gameType: "Badminton",
                   gameIcon: "figure.badminton",
                   date: "22 Nov, Evening",
                   location: "Court 1, chitkara university",
                   time: "19:00",
                   isCompleted: false
               )
           ]
           
           // Add sample games to GameDataManager if needed
           sampleGames.forEach { game in
               if gameDataManager.getAllGames().contains(where: { $0.id == game.id }) == false {
                   gameDataManager.addGame(game)
               }
           }
       }
    
    private func filterGames() {
            if let gameType = selectedGameType {
                filteredGames = gameDataManager.getGamesOfType(gameType)
                updateGamesCreatedLabel()
            }
        }
        
        private func updateGamesCreatedLabel() {
            gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
        }
        
        // MARK: - Actions
        @IBAction func createGameTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let createGameVC = storyboard.instantiateViewController(withIdentifier: "CreateGameViewController") as? CreateGameViewController {
                let nav = UINavigationController(rootViewController: createGameVC)
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }
        }
    

}


extension GameEventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameEventTableViewCell.identifier, for: indexPath) as? GameEventTableViewCell else {
            return UITableViewCell()
        }
        
        let gameData = filteredGames[indexPath.row]
        cell.configure(with: gameData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameData = filteredGames[indexPath.row]
                navigateToGameDetails(with: gameData)
    }
    
    private func navigateToGameDetails(with game: GameData) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let gameDetailsVC = storyboard.instantiateViewController(withIdentifier: "BadmintonGameViewController") as? BadmintonGameViewController {
                gameDetailsVC.gameTitle = game.personName
                gameDetailsVC.gameLocation = game.location ?? ""
                gameDetailsVC.gameDate = game.date ?? ""
                // Add any other necessary game details
                navigationController?.pushViewController(gameDetailsVC, animated: true)
            }
        }
}

extension GameEventsViewController: CreateGameDelegate {
    func gameCreated(sport: String, area: String, date: String, time: String) {
        let newGame = GameData.createNew(sport: sport, area: area, date: date, time: time)
        gameDataManager.addGame(newGame)
        filterGames()
        tableView.reloadData()
    }
}
