//
//  InterestSectionViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 17/01/25.
//

import UIKit

class InterestSectionViewController: UIViewController {
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
    
    var filteredGames: [GameData] = []
    private let gameDataManager = GameDataManager.shared
    
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
    
    private func initializeGamesData() {
            let sampleGames = [
                GameData(
                    id: 1,
                    personName: "Aseem Bhardwaj",
                    personImage: "person1",
                    going: "5 Going",
                    mutual: "2 Mutual",
                    gameType: "Badminton",
                    gameIcon: "figure.badminton",
                    date: "26 Dec, Night",
                    location: "Court 1, Chitkara university",
                    time: "19:00",
                    isCompleted: false
                ),
                GameData(
                    id: 2,
                    personName: "Sarah Parker",
                    personImage: "person2",
                    going: "8 Going",
                    mutual: "3 Mutual",
                    gameType: "Basketball",
                    gameIcon: "figure.basketball",
                    date: "28 Dec, Evening",
                    location: "Court 2, Chitkara university",
                    time: "19:00",
                    isCompleted: false
                )
                // Add other sample games with proper IDs
            ]
            
            // Initialize GameDataManager with sample data if needed
            sampleGames.forEach { game in
                if !gameDataManager.getAllGames().contains(where: { $0.id == game.id }) {
                    gameDataManager.addGame(game)
                }
            }
        }
        
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           filterGames() // Refresh games when view appears
       }
       
    
    private func setupGameCardTapGesture() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gameCardTapped))
         gameCardView.addGestureRecognizer(tapGesture)
         gameCardView.isUserInteractionEnabled = true
     }
      
    @objc private func gameCardTapped() {
           performSegue(withIdentifier: "showBadmintonGame", sender: self)
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
            // Update all UI elements with game data
            regularLabel.text = "Regular"
            nameLabel.text = game.personName
            attendanceLabel.text = game.going
            dateLabel.text = game.date ?? "Date unavailable"
            locationLabel.text = game.location ?? "Location unavailable"
            
        updateProfileImage(with: game.personImage)
               updatePlayingButton()
               showGameCard()
        }

    private func updateProfileImage(with imageName: String) {
          if let image = UIImage(named: imageName) {
              profileImageView.image = image
          } else {
              profileImageView.image = UIImage(systemName: "person.circle.fill")
          }
      }
      
      private func updatePlayingButton() {
          playingButton.isHidden = false
          playingButton.setTitle("Playing", for: .normal)
          playingButton.backgroundColor = .systemGreen
      }
      
      private func showGameCard() {
          gameCardView.isHidden = false
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
        configureGameCard()
               configureProfileImage()
               configurePlayingButton()
               configureLabels()
        }
    
    private func configureGameCard() {
           gameCardView.layer.cornerRadius = 10
       }
       
       private func configureProfileImage() {
           profileImageView.layer.cornerRadius = 20
           profileImageView.clipsToBounds = true
       }
       
       private func configurePlayingButton() {
           playingButton.layer.cornerRadius = 12
       }
       
       private func configureLabels() {
           attendanceLabel.textColor = .systemGray
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
        
            print("Present filter tapped")
        }
        
        @IBAction func playingButtonTapped(_ sender: UIButton) {
            // Handle playing status action
            print("Playing status tapped")
        }
    
 

}

extension InterestSectionViewController:  UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // Handle tab selection
        print("Selected tab at index: \(item.tag)")
    }
}

extension InterestSectionViewController: CreateGameDelegate {
    func gameCreated(sport: String, area: String, date: String, time: String) {
        let newGame = GameData.createNew(sport: sport, area: area, date: date, time: time)
        gameDataManager.addGame(newGame)
        
        if selectedGameType == nil || selectedGameType == sport {
            filterGames()
        }
    }
}
