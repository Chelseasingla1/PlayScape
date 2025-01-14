//
//  GameDetailsViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 19/12/24.
//

import UIKit

class GameDetailsViewController: UIViewController {

    var gameType: String = ""
    private let scrollView = UIScrollView()
        private let contentView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = gameType
              view.backgroundColor = .black // For dark mode theme
        setupScrollView()
                setupContentStack()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupScrollView() {
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(scrollView)
           
           NSLayoutConstraint.activate([
               scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }
    
    private func setupContentStack() {
           contentView.axis = .vertical
           contentView.spacing = 20
           contentView.alignment = .fill
           contentView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(contentView)
           
           NSLayoutConstraint.activate([
               contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
               contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
               contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
               contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
           ])
       }
    
    
    
    private func setupUI() {
            // Add your game details UI here
            let label = UILabel()
            label.text = "Game Details for \(gameType)"
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(label)
            
        let imageView = UIImageView()
              imageView.backgroundColor = .darkGray
              imageView.layer.cornerRadius = 12
              imageView.clipsToBounds = true
              imageView.contentMode = .scaleAspectFill
              imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
              contentView.addArrangedSubview(imageView)
              
              // Game Description
              let descriptionLabel = createLabel(
                  text: getGameDescription(),
                  fontSize: 16,
                  color: .white
              )
              contentView.addArrangedSubview(descriptionLabel)
        
        let rulesTitle = createLabel(text: "Rules", fontSize: 20, weight: .bold)
                contentView.addArrangedSubview(rulesTitle)
                
                let rulesLabel = createLabel(text: getGameRules(), fontSize: 16)
                contentView.addArrangedSubview(rulesLabel)
                
                // Equipment Section
                let equipmentTitle = createLabel(text: "Required Equipment", fontSize: 20, weight: .bold)
                contentView.addArrangedSubview(equipmentTitle)
                
                let equipmentLabel = createLabel(text: getRequiredEquipment(), fontSize: 16)
                contentView.addArrangedSubview(equipmentLabel)
                
                // Join Game Button
                let joinButton = UIButton(type: .system)
                joinButton.setTitle("Join a Game", for: .normal)
                joinButton.backgroundColor = .systemBlue
                joinButton.setTitleColor(.white, for: .normal)
                joinButton.layer.cornerRadius = 8
                joinButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                joinButton.addTarget(self, action: #selector(joinGameTapped), for: .touchUpInside)
                contentView.addArrangedSubview(joinButton)
        
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
   
    private func createLabel(text: String, fontSize: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = .white) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = .systemFont(ofSize: fontSize, weight: weight)
            label.textColor = color
            label.numberOfLines = 0
            return label
        }
    
    
    @objc private func joinGameTapped() {
            let alert = UIAlertController(
                title: "Join Game",
                message: "Would you like to join an existing game or create a new one?",
                preferredStyle: .actionSheet
            )
            
            alert.addAction(UIAlertAction(title: "Join Existing", style: .default) { _ in
                self.showExistingGames()
            })
            
            alert.addAction(UIAlertAction(title: "Create New", style: .default) { _ in
                self.showCreateGame()
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(alert, animated: true)
        }
    
    private func showExistingGames() {
            // Implementation for showing existing games
            print("Show existing games")
        }
        
        private func showCreateGame() {
            // Implementation for creating new game
            print("Show create game form")
        }
    
    private func getGameDescription() -> String {
            switch gameType.lowercased() {
            case "badminton":
                return "Badminton is a racquet sport played by either two players (singles) or two pairs (doubles), who take positions on opposite halves of a rectangular court that is divided by a net."
            case "basketball":
                return "Basketball is a team sport in which two teams, most commonly of five players each, opposing one another on a rectangular court, compete with the primary objective of shooting a basketball through the defender's hoop."
            case "football":
                return "Football is a team sport played between two teams of eleven players each. It is played with a spherical ball and is the most popular sport in the world."
            case "boxing":
                return "Boxing is a combat sport in which two people, usually wearing protective gloves and other protective equipment, throw punches at each other for a predetermined amount of time in a boxing ring."
            case "tennis":
                return "Tennis is a racket sport that can be played individually against a single opponent (singles) or between two teams of two players each (doubles)."
            default:
                return "Details coming soon..."
            }
        }
    
    private func getGameRules() -> String {
            switch gameType.lowercased() {
            case "badminton":
                return "• Games are played to 21 points\n• Points can only be scored by the serving side\n• A point is scored on every serve\n• Players must serve diagonally across the court"
            case "basketball":
                return "• Each basket is worth 2 points\n• Three-point shots must be taken from behind the three-point line\n• Players cannot run with the ball without dribbling\n• A game consists of four quarters"
            default:
                return "Rules coming soon..."
            }
        }
        
        private func getRequiredEquipment() -> String {
            switch gameType.lowercased() {
            case "badminton":
                return "• Badminton racquet\n• Shuttlecock\n• Appropriate sports shoes\n• Sports clothing"
            case "basketball":
                return "• Basketball\n• Basketball shoes\n• Comfortable clothing\n• Water bottle"
            default:
                return "Equipment list coming soon..."
            }
        }
    
}
