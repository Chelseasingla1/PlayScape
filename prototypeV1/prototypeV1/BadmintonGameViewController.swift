//
//  BadmintonGameViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 15/01/25.
//

import UIKit

class BadmintonGameViewController: UIViewController {

    @IBOutlet weak var gameImageView: UIImageView!
       @IBOutlet weak var dateLabel: UILabel!
       @IBOutlet weak var inChargeLabel: UILabel!
       
       @IBOutlet weak var rulesLabel: UILabel!
       @IBOutlet weak var respectCheckImageView: UIImageView!
       @IBOutlet weak var beGoodCheckImageView: UIImageView!
       @IBOutlet weak var staySafeCheckImageView: UIImageView!
       
       @IBOutlet weak var participantsLabel: UILabel!
       @IBOutlet weak var participantsTableView: UITableView!
       @IBOutlet weak var joinButton: UIButton!
       
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var participants: [(name: String, level: Int, joinedDate: String)] = []
        
    var gameTitle: String?
       var gameLevel: String?
       var gameLocation: String?
       var gameDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupUI()
                setupParticipantsData()
                configureTableView()
        updateGameDetails()
        // Do any additional setup after loading the view.
    }
    
    @objc private func refreshData() {
        // Add your refresh logic here
        scrollView.refreshControl?.endRefreshing()
    }
    
    private func updateGameDetails() {
           // Update UI with passed game data
           navigationItem.title = gameTitle
           dateLabel.text = "Date: \(gameDate ?? "")"
           
           // You can add more labels/views to display level and location
           let levelView = UILabel()
           levelView.text = "Level: \(gameLevel ?? "")"
           let locationView = UILabel()
           locationView.text = "Location: \(gameLocation ?? "")"
           
           // Add these views to your contentView or appropriate container
           // Configure their layout constraints as needed
       }
    
    private func setupUI() {
            // Navigation setup
            navigationItem.title = "Badminton Game"
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(backButtonTapped))
            
            // Game image setup
            gameImageView.layer.cornerRadius = 12
            gameImageView.clipsToBounds = true
            gameImageView.contentMode = .scaleAspectFill
            
            // Details section setup
            dateLabel.text = "Date: Dec 12, 8:00 AM"
            inChargeLabel.text = "In Charge: Liam Wilson"
            
            // Rules section setup
            rulesLabel.text = "Rules to follow"
            
        // Join button setup
//                joinButton.layer.cornerRadius = 8
//                joinButton.backgroundColor = UIColor(red: 75/255, green: 141/255, blue: 112/255, alpha: 1)
//                joinButton.setTitle("Join", for: .normal)
//                joinButton.setTitleColor(.white, for: .normal)
                
                // Tab bar setup
              //  tabBar.selectedItem = tabBar.items?[1]
            }
    
    private func setupParticipantsData() {
           participants = [
               ("Lucas Martin", 2, "2 days ago"),
               ("Harper Martinez", 12, "3 months ago")
           ]
       }
    
    private func setupScrollView() {
        // Configure scroll view
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        // Add refresh control (optional)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                               action: #selector(refreshData),
                               for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    private func configureTableView() {
            participantsTableView.delegate = self
            participantsTableView.dataSource = self
            participantsTableView.register(ParticipantCell.self, forCellReuseIdentifier: "ParticipantCell")
            participantsTableView.isScrollEnabled = false
            participantsTableView.backgroundColor = .clear
        }
    
    // MARK: - Actions
        @IBAction func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        @IBAction func joinButtonTapped() {
            // Handle join action
            let alert = UIAlertController(title: "Join Game",
                                        message: "Would you like to join this badminton game?",
                                        preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Join", style: .default) { [weak self] _ in
                // Handle join logic
                self?.joinButton.setTitle("Joined", for: .normal)
                self?.joinButton.isEnabled = false
            })
            
            present(alert, animated: true)
        }

}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension BadmintonGameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParticipantCell", for: indexPath) as! ParticipantCell
        let participant = participants[indexPath.row]
        cell.configure(name: participant.name,
                      level: participant.level,
                      joinedDate: participant.joinedDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


