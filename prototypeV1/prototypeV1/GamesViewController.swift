//
//  GamesViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

class GamesViewController: UIViewController {
    
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
       @IBOutlet weak var tabBar: UITabBar!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupNavigationBar()
        gameCardView.isHidden = true
        }
        
    private func setupUI() {
            // Configure game card view
            gameCardView.layer.cornerRadius = 10
            gameCardView.backgroundColor = .systemGray6
            
            // Configure profile image view
            profileImageView.layer.cornerRadius = 20
            profileImageView.clipsToBounds = true
            
            // Configure playing button
            playingButton.layer.cornerRadius = 12
            playingButton.backgroundColor = .systemGreen
            
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
