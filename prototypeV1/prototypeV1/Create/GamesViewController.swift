//
//  GamesViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

class GamesViewController: UIViewController {
    var selectedGameType: String?
    
    @IBOutlet weak var createGameButton: UIButton!
       @IBOutlet weak var gamesCreatedLabel: UILabel!
       @IBOutlet weak var presentButton: UIButton!
       @IBOutlet weak var gameCardView: UIView!
       @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var regularLabel: UILabel!
       @IBOutlet weak var playingButton: UIButton!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var attendanceLabel: UILabel!
       @IBOutlet weak var dateLabel: UILabel!
       @IBOutlet weak var skillLabel: UILabel!
       @IBOutlet weak var locationLabel: UILabel!

    
        private let gameDataManager = GameDataManager.shared
    
    private struct SportHistory {
        let type: String
        let games: [HistoryGame]
    }
    
    private struct HistoryGame {
        let sport: String
        let date: String
        let participants: Int
    }
    
    private var sportsHistory: [SportHistory] = [
        SportHistory(type: "Hosted", games: [
            HistoryGame(sport: "Basketball", date: "15 Nov 2024", participants: 8),
            HistoryGame(sport: "Badminton", date: "10 Nov 2024", participants: 4),
            HistoryGame(sport: "Cricket", date: "5 Nov 2024", participants: 12)
        ]),
        SportHistory(type: "Played", games: [
            HistoryGame(sport: "Football", date: "12 Nov 2024", participants: 10),
            HistoryGame(sport: "Basketball", date: "8 Nov 2024", participants: 6),
            HistoryGame(sport: "Badminton", date: "1 Nov 2024", participants: 2)
        ])
    ]
    
 var filteredGames: [GameData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGameCardTapGesture()
        initializeGamesData()
        
        if let gameType = selectedGameType {
            navigationItem.title = gameType
            filterGames()
            
        }
        
        // Filter and display games based on selected type
       
        gameCardView.isHidden = true
    }
        
    
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          filterGames() // Refresh when view appears
      }
    
    private func setupGameCardTapGesture() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gameCardTapped))
         gameCardView.addGestureRecognizer(tapGesture)
         gameCardView.isUserInteractionEnabled = true
     }
      
    @objc private func gameCardTapped() {
           performSegue(withIdentifier: "showBadmintonGame", sender: self)
       }
    
   
    private func initializeGamesData() {
            let sampleGames = [
                GameData(id: 1,
                        personName: "Aseem Bhardwaj",
                        personImage: "person1",
                        going: "5 Going",
                        mutual: "2 Mutual",
                        gameType: "Badminton",
                        gameIcon: "figure.badminton",
                        date: "26 Dec, Night",
                        location: "Court 1, Chitkara university",
                        time: "19:00",
                        isCompleted: false),
                GameData(id: 2,
                        personName: "Sarah Parker",
                        personImage: "person2",
                        going: "8 Going",
                        mutual: "3 Mutual",
                        gameType: "Badminton",
                        gameIcon: "figure.badminton",
                        date: "28 Dec, Evening",
                        location: "Court 2, Chitkara university",
                        time: "19:00",
                        isCompleted: false)
               
            ]
            
            // Add sample games to GameDataManager if needed
            sampleGames.forEach { game in
                if gameDataManager.getAllGames().contains(where: { $0.id == game.id }) == false {
                    gameDataManager.addGame(game)
                }
            }
        }
        
    
    private func filterGames() {
        guard let gameType = selectedGameType else { return }
               
               filteredGames = gameDataManager.getGamesOfType(gameType)
               
               if let firstGame = filteredGames.first {
                   updateUIWithGame(firstGame)
               } else {
                   gameCardView.isHidden = true
               }
               
               gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
         
      }
      
    
    private func updateUIWithGame(_ game: GameData) {
            
        regularLabel.text = "Regular"
               nameLabel.text = game.personName
               attendanceLabel.text = game.going
               dateLabel.text = game.date ?? "Date unavailable"
               locationLabel.text = game.location ?? "Location unavailable"
               
               setupProfileImage(with: game.personImage)
               setupPlayingButton()
               setupGameCard()
               
               gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
        }

    private func setupProfileImage(with imageName: String) {
           if let image = UIImage(named: imageName) {
               profileImageView.image = image
           } else {
               profileImageView.image = UIImage(systemName: "person.circle.fill")
           }
           profileImageView.layer.cornerRadius = 20
           profileImageView.clipsToBounds = true
       }
    private func setupPlayingButton() {
           playingButton.isHidden = false
           playingButton.setTitle("Playing", for: .normal)
           playingButton.backgroundColor = .systemGreen
           playingButton.layer.cornerRadius = 12
       }
       
       private func setupGameCard() {
           gameCardView.isHidden = false
           gameCardView.layer.cornerRadius = 10
           attendanceLabel.textColor = .systemGray
       }
    
    private func updateGameCards() {
        // Hide game card if no games available
        gameCardView.isHidden = filteredGames.isEmpty

        // Update game card with first game if available
        if let firstGame = filteredGames.first {
            regularLabel.text = "Regular"
            nameLabel.text = firstGame.personName
            attendanceLabel.text = firstGame.going

            // Use optional binding to safely unwrap date and location
            if let gameDate = firstGame.date {
                dateLabel.text = gameDate
            } else {
                dateLabel.text = "Date unavailable"
            }

            if let gameLocation = firstGame.location {
                locationLabel.text = gameLocation
            } else {
                locationLabel.text = "Location unavailable"
            }

            // Show the playing button
            playingButton.isHidden = false
            playingButton.setTitle("Playing", for: .normal)
            playingButton.backgroundColor = .systemGreen

            // Show the game card
            gameCardView.isHidden = false
        }
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showBadmintonGame" {
               if let destinationVC = segue.destination as? BadmintonGameViewController {
                  
               }
           }
      
        
       }

    
    private func setupUI() {
            // Configure game card view
            gameCardView.layer.cornerRadius = 10
           // gameCardView.backgroundColor = .systemGray6
            
            // Configure profile image view
            profileImageView.layer.cornerRadius = 20
            profileImageView.clipsToBounds = true
            
            // Configure playing button
            playingButton.layer.cornerRadius = 12
          //  playingButton.backgroundColor = .systemGreen
            
            // Configure labels
          //  skillLabel.textColor = .systemGray
           // dateLabel.textColor = .systemGray
            attendanceLabel.textColor = .systemGray
          //  locationLabel.textColor = .systemGray
            
            // Configure tab bar
            //tabBar.selectedItem = tabBar.items?[1]
        }
    
    private func setupNavigationBar() {
            let titleLabel = UILabel()
            titleLabel.text = "Games"
            titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            
            let profileButton = UIButton(type: .system)
            profileButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
            profileButton.tintColor = .label
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        }
        
        // MARK: - Actions
        @IBAction func createGameTapped(_ sender: UIButton) {
            // Handle create game action
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let createVC = storyboard.instantiateViewController(withIdentifier: "CreateGameViewController") as? CreateGameViewController {
                        let nav = UINavigationController(rootViewController: createVC)
                        nav.modalPresentationStyle = .fullScreen
                        createVC.delegate = self
                        present(nav, animated: true)
                    }
            print("Create game tapped")
        }
    
    
    @IBAction func presentButtonTapped(_ sender: UIButton) {
            // Handle present filter action
        let dropdownMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Create section headers and items
        for category in sportsHistory {
            // Add section header
            let headerAction = UIAlertAction(title: category.type, style: .default) { _ in }
            headerAction.setValue(UIColor.darkGray, forKey: "titleTextColor")
            dropdownMenu.addAction(headerAction)
            
            // Add games for this category
            for game in category.games {
                let gameAction = UIAlertAction(title: formatHistoryGameTitle(game), style: .default) { [weak self] _ in
                    self?.handleHistoryGameSelection(game, category: category.type)
                }
                dropdownMenu.addAction(gameAction)
            }
        }
        
        // Add cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        dropdownMenu.addAction(cancelAction)
        
//        // Present the dropdown
//        if let popover = dropdownMenu.popoverPresentationController {
//            popover.sourceView = sender
//            popover.sourceRect = sender.bounds
//        }
        
        present(dropdownMenu, animated: true)
        
        }
    
    
    private func handleHistoryGameSelection(_ game: HistoryGame, category: String) {
        // Update Present button text
        presentButton.setTitle("\(category): \(game.sport)", for: .normal)
        
        // Update the game card UI
        regularLabel.text = category
        nameLabel.text = "me"
        attendanceLabel.text = "\(game.participants) participated"
        dateLabel.text = game.date
        
        // Set location based on the sport
        let location: String
        switch game.sport {
        case "Basketball":
            location = "Basketball Court, Chitkara university"
        case "Badminton":
            location = "Court 1, Chitkara university"
        case "Cricket":
            location = "Cricket Ground, Chitkara university"
        case "Football":
            location = "Football Field, Chitkara university"
        default:
            location = "Chitkara university"
        }
        locationLabel.text = location
        
        // Configure profile image
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.tintColor = .systemGray
        
        // Configure playing button based on category
        if category == "Hosted" {
            playingButton.setTitle("Hosted", for: .normal)
            playingButton.backgroundColor = .systemBlue
        } else {
            playingButton.setTitle("Played", for: .normal)
            playingButton.backgroundColor = .systemGreen
        }
        
        // Show the game card with animation
        UIView.animate(withDuration: 0.3) {
            self.gameCardView.alpha = 0
            self.gameCardView.isHidden = false
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.gameCardView.alpha = 1
            }
        }
    }
        
    private func formatHistoryGameTitle(_ game: HistoryGame) -> String {
        return "\(game.sport) - \(game.date) (\(game.participants) players)"
    }

    
        
        @IBAction func playingButtonTapped(_ sender: UIButton) {
            // Handle playing status action
            print("Playing status tapped")
        }
    
    
}


extension GamesViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Handle tab selection
        print("Selected tab at index: \(item.tag)")
    }
}

extension GamesViewController: CreateGameDelegate {
    func gameCreated(sport: String, area: String, date: String, time: String) {
        // Create new game data
      
        let newGame = GameData.createNew(sport: sport, area: area, date: date, time: time)
        gameDataManager.addGame(newGame)
        
        if selectedGameType == nil || selectedGameType == sport {
            filteredGames.insert(newGame, at: 0)
            updateUIWithNewGame(newGame)
            gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
        }
    }
}

private extension GamesViewController {
    func formatGameDateTime(_ date: String, _ time: String) -> String {
        return "\(date), \(time)"
    }
    
    func updateUIWithNewGame(_ game: GameData) {
        // Configure card appearance
        gameCardView.layer.shadowColor = UIColor.black.cgColor
        gameCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        gameCardView.layer.shadowRadius = 4
        gameCardView.layer.shadowOpacity = 0.1
        
        // Update labels with game info
        regularLabel.text = "New Game"
        nameLabel.text = game.personName
        attendanceLabel.text = game.going
        
        if let gameDate = game.date, let gameTime = game.time {
            dateLabel.text = formatGameDateTime(gameDate, gameTime)
        }
        
        locationLabel.text = game.location
        
        // Configure profile image
        if game.personImage.contains("person.circle") {
            profileImageView.image = UIImage(systemName: game.personImage)
            profileImageView.tintColor = .systemGray
        } else {
            profileImageView.image = UIImage(named: game.personImage)
        }
        
        // Show the card
        gameCardView.isHidden = false
    }
}
