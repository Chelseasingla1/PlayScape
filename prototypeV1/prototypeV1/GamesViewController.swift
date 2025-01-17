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

 var filteredGames: [GameData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGameCardTapGesture()
        
        if let gameType = selectedGameType {
            navigationItem.title = gameType
            filterGames()
            
        }
        
        // Filter and display games based on selected type
       
        gameCardView.isHidden = true
    }
        
    private func setupGameCardTapGesture() {
         let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gameCardTapped))
         gameCardView.addGestureRecognizer(tapGesture)
         gameCardView.isUserInteractionEnabled = true
     }
      
    @objc private func gameCardTapped() {
           performSegue(withIdentifier: "showBadmintonGame", sender: self)
       }
    
    private var gamesData: [GameData] = [
           // Badminton Events
           GameData(
               personName: "Aseem Bhardwaj",
               personImage: "person1",
               going: "5 Going",
               mutual: "2 Mutual",
               gameType: "Badminton",
               gameIcon: "figure.badminton",
               date: "26 Dec, Night",
               location: "Court 1, Chitkara university"
           ),
           GameData(
               personName: "Sarah Parker",
               personImage: "person2",
               going: "8 Going",
               mutual: "3 Mutual",
               gameType: "Badminton",
               gameIcon: "figure.badminton",
               date: "28 Dec, Evening",
               location: "Court 2, Chitkara university"
           ),
           
           // Basketball Events
           GameData(
               personName: "Alex Garrison",
               personImage: "person3",
               going: "10 Going",
               mutual: "4 Mutual",
               gameType: "Basketball",
               gameIcon: "figure.basketball",
               date: "27 Dec, Evening",
               location: "Basketball Court, Chitkara university"
           ),
           
           // Cricket Events
           GameData(
               personName: "Rahul Kumar",
               personImage: "person5",
               going: "12 Going",
               mutual: "5 Mutual",
               gameType: "Cricket",
               gameIcon: "figure.cricket",
               date: "30 Dec, Morning",
               location: "Cricket Ground, Chitkara university"
           ),
           
           // Football Events
           GameData(
               personName: "David Wilson",
               personImage: "person7",
               going: "14 Going",
               mutual: "4 Mutual",
               gameType: "Football",
               gameIcon: "figure.football",
               date: "28 Dec, Evening",
               location: "Football Field, Chitkara university"
           )
       ]
       
    
    private func filterGames() {
          guard let gameType = selectedGameType else { return }
          
          // Filter games based on selected type
          filteredGames = gamesData.filter { $0.gameType == gameType }
          
          // Update UI with first filtered game
          if let firstGame = filteredGames.first {
              updateUIWithGame(firstGame)
          } else {
              gameCardView.isHidden = true
          }
      }
      
    
    private func updateUIWithGame(_ game: GameData) {
            // Update all UI elements with game data
            regularLabel.text = "Regular"
            nameLabel.text = game.personName
            attendanceLabel.text = game.going
            dateLabel.text = game.date ?? "Date unavailable"
            locationLabel.text = game.location ?? "Location unavailable"
            
            // Update profile image if available
            if let image = UIImage(named: game.personImage) {
                profileImageView.image = image
            } else {
                profileImageView.image = UIImage(systemName: "person.circle.fill")
            }
            
            // Configure playing button
            playingButton.isHidden = false
            playingButton.setTitle("Playing", for: .normal)
            playingButton.backgroundColor = .systemGreen
            playingButton.layer.cornerRadius = 12
            
            // Show the game card
            gameCardView.isHidden = false
            gameCardView.layer.cornerRadius = 10
            
            // Style labels
            attendanceLabel.textColor = .systemGray
            
            // Update games created label if needed
            gamesCreatedLabel.text = "\(filteredGames.count) Games Created"
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
        
            print("Present filter tapped")
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
        // Update UI with new game
        regularLabel.text = "Regular"
        nameLabel.text = "Alex Garrison"
        attendanceLabel.text = "1 Going"
//        skillLabel.text = "Beginner"
//        dateLabel.text = "\(date), \(time)"
//        locationLabel.text = area
        playingButton.isHidden = false
        gameCardView.isHidden = false
    }
}
