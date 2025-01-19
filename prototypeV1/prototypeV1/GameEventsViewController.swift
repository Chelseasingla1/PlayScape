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
       
       // Sample data
       private var gamesData: [GameData] = [
           GameData(
               personName: "Hailey Anderson",
               personImage: "profile1",
               going: "1 Going",
               mutual: "2 Mutual",
               gameType: "Badminton",
               gameIcon: "figure.badminton",
               date: "12 Nov, Evening",
               location: "Court 1, chitkara university",
               time:"19:00"
              /// skillLevel: "Beginner"
           ),
           GameData(
               personName: "Hola Anderson",
               personImage: "profile2",
               going: "1 Going",
               mutual: "3 Mutual",
               gameType: "Badminton",
               gameIcon: "figure.badminton",
               date: "22 Nov, Evening",
               location: "Court 1, chitkara university",
               time:"19:00"
             ///  skillLevel: "Beginner"
           )
       ]
       
       // MARK: - Lifecycle
       override func viewDidLoad() {
           super.viewDidLoad()
           setupUI()
           setupTableView()
           filterGames()
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
    
    private func filterGames() {
            if let gameType = selectedGameType {
                filteredGames = gamesData.filter { $0.gameType == gameType }
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
        // Handle cell selection if needed
        let gameData = filteredGames[indexPath.row]
        print("Selected game: \(gameData.personName)")
    }
}

// MARK: - CreateGameViewController Delegate (if needed)
//protocol CreateGameDelegate: AnyObject {
//    func gameCreated(sport: String, area: String, date: String, time: String)
//}

extension GameEventsViewController: CreateGameDelegate {
    func gameCreated(sport: String, area: String, date: String, time: String) {
        // Handle new game creation
        filterGames()
        tableView.reloadData()
    }
}
