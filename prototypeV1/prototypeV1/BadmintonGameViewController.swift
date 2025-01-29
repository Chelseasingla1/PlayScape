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
    }
    
    @objc private func refreshData() {
        scrollView.refreshControl?.endRefreshing()
    }
    
    private func updateGameDetails() {
        navigationItem.title = gameTitle
        dateLabel.text = "Date: \(gameDate ?? "")"
           
        let levelView = UILabel()
        levelView.text = "Level: \(gameLevel ?? "")"
        let locationView = UILabel()
        locationView.text = "Location: \(gameLocation ?? "")"
           
    }
    
    private func setupUI() {
        navigationItem.title = "Badminton Game"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"),
                    style: .plain,
                    target: self,
                    action: #selector(backButtonTapped))
            
        gameImageView.layer.cornerRadius = 12
        gameImageView.clipsToBounds = true
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.image = UIImage(named: "badminton")
        dateLabel.text = "Date: Dec 12, 8:00 AM"
        inChargeLabel.text = "In Charge: Liam Wilson"
        rulesLabel.text = "Rules to follow"
            
        
    }
    
    private func setupParticipantsData() {
        participants = [
            ("Lucas Martin", 2, "2 days ago"),
            ("Harper Martinez", 12, "3 months ago")
        ]
    }
    
    private func setupScrollView() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
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
            let alert = UIAlertController(title: "Join Game",
                    message: "Would you like to join this badminton game?",
                    preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Join", style: .default) { [weak self] _ in
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


