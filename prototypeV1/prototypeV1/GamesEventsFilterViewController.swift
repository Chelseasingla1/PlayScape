//
//  GamesEventsFilterViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 17/01/25.
//

import UIKit

class GamesEventsFilterViewController: UIViewController {

    @IBOutlet weak var createGameButton: UIButton!
        @IBOutlet weak var gamesCreatedLabel: UILabel!
        @IBOutlet weak var tableView: UITableView!
        
    private let gameDataManager = GameDataManager.shared
    private var filteredGames: [GameData] = []
        private var selectedGameTypes: Set<String> = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupTableView()
            setupFilterButton()
            initializeGamesData()
            applyFilters()
        }
        
    private func initializeGamesData() {
           // Add sample data if needed
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
                   personName: "Alex Garrison",
                   personImage: "profile2",
                   going: "1 Going",
                   mutual: "3 Mutual",
                   gameType: "Basketball",
                   gameIcon: "basketball.fill",
                   date: "22 Nov, Evening",
                   location: "Court 2, chitkara university",
                   time: "19:00",
                   isCompleted: false
               )
           ]
           
           // Add sample games if they don't exist
           sampleGames.forEach { game in
               if gameDataManager.getAllGames().contains(where: { $0.id == game.id }) == false {
                   gameDataManager.addGame(game)
               }
           }
       }
       
    
        // MARK: - Setup
        private func setupUI() {
            view.backgroundColor = .black
            navigationItem.title = "Games"
            
            createGameButton.setTitle("+ Create Game", for: .normal)
            createGameButton.setTitleColor(.systemBlue, for: .normal)
        }
        
    private func setupTableView() {
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
        
        private func setupFilterButton() {
            let filterButton = UIButton(type: .system)
            filterButton.setTitle("Filter Games", for: .normal)
            filterButton.setImage(UIImage(systemName: "line.3.horizontal.decrease.circle"), for: .normal)
            filterButton.tintColor = .white
            filterButton.titleLabel?.font = .systemFont(ofSize: 16)
            filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
            
            let filterBarButton = UIBarButtonItem(customView: filterButton)
            navigationItem.rightBarButtonItem = filterBarButton
        }
        
        private func updateGamesCreatedLabel() {
            gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
        }
        
        @objc private func filterButtonTapped() {
            let alertController = UIAlertController(title: "Filter by Game Type",
                                                          message: nil,
                                                          preferredStyle: .actionSheet)
                    
                    // Get unique game types from GameDataManager
                    let gameTypes = Array(Set(gameDataManager.getAllGames().map { $0.gameType }))
                    
                    for gameType in gameTypes {
                        let isSelected = selectedGameTypes.contains(gameType)
                        let action = UIAlertAction(title: gameType, style: .default) { [weak self] _ in
                            self?.toggleGameTypeFilter(gameType)
                        }
                        action.setValue(isSelected, forKey: "checked")
                        alertController.addAction(action)
                    }
                    
                    let clearFiltersAction = UIAlertAction(title: "Clear Filters", style: .destructive) { [weak self] _ in
                        self?.clearFilters()
                    }
                    alertController.addAction(clearFiltersAction)
                    
                    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    alertController.addAction(cancelAction)
                    
                    if let popoverController = alertController.popoverPresentationController {
                        popoverController.barButtonItem = navigationItem.rightBarButtonItem
                    }
                    
                    present(alertController, animated: true)
             
        }
        
        private func toggleGameTypeFilter(_ gameType: String) {
            if selectedGameTypes.contains(gameType) {
                selectedGameTypes.remove(gameType)
            } else {
                selectedGameTypes.insert(gameType)
            }
            applyFilters()
        }
        
        private func clearFilters() {
            selectedGameTypes.removeAll()
            applyFilters()
        }
        
    private func applyFilters() {
           let allGames = gameDataManager.getAllGames()
           if selectedGameTypes.isEmpty {
               filteredGames = allGames
           } else {
               filteredGames = allGames.filter { selectedGameTypes.contains($0.gameType) }
           }
           updateGamesCreatedLabel()
           tableView.reloadData()
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

extension GamesEventsFilterViewController: UITableViewDelegate, UITableViewDataSource {
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
                navigationController?.pushViewController(gameDetailsVC, animated: true)
            }
        }
}

// MARK: - CreateGameDelegate
extension GamesEventsFilterViewController: CreateGameDelegate {
    func gameCreated(sport: String, area: String, date: String, time: String) {
            let newGame = GameData.createNew(sport: sport, area: area, date: date, time: time)
            gameDataManager.addGame(newGame)
            applyFilters()
        }
}
