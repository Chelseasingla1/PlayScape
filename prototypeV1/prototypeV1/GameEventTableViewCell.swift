//
//  GameEventTableViewCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 17/01/25.
//

import UIKit

class GameEventTableViewCell: UITableViewCell {

    static let identifier = "GamesEventCell"
    
    @IBOutlet weak var containerView: UIView!
       @IBOutlet weak var profileImageView: UIImageView!
       @IBOutlet weak var regularLabel: UILabel!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var goingLabel: UILabel!
       @IBOutlet weak var dateLabel: UILabel!
       @IBOutlet weak var locationLabel: UILabel!
       @IBOutlet weak var skillLevelView: UIView!
       @IBOutlet weak var skillLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }

    private func setupUI() {
           // Container View
           containerView.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
           containerView.layer.cornerRadius = 12
           
           // Profile Image
           profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
           profileImageView.clipsToBounds = true
           
           // Labels
           regularLabel.text = "Regular"
           regularLabel.textColor = .white
           regularLabel.font = .systemFont(ofSize: 14)
           
           nameLabel.textColor = .white
           nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
           
           goingLabel.textColor = .systemGray
           goingLabel.font = .systemFont(ofSize: 14)
           
           dateLabel.textColor = .white
           dateLabel.font = .systemFont(ofSize: 14)
           
           locationLabel.textColor = .systemGray
           locationLabel.font = .systemFont(ofSize: 14)
           
           // Skill Level View
          // skillLevelView.backgroundColor = .systemRed
          // skillLevelView.layer.cornerRadius = 8
           
           skillLevelLabel.textColor = .white
           skillLevelLabel.font = .systemFont(ofSize: 12)
           
           // Cell
           backgroundColor = .clear
           contentView.backgroundColor = .clear
           selectionStyle = .none
       }
       
       func configure(with game: GameData) {
           profileImageView.image = UIImage(named: game.personImage) ?? UIImage(systemName: "person.circle")
           nameLabel.text = "\(game.personName) | \(game.gameType)"
           goingLabel.text = game.going
           dateLabel.text = game.date ?? "Date not specified"
           locationLabel.text = game.location ?? "Location not specified"
           //skillLevelLabel.text = game.skillLevel
       }

}
