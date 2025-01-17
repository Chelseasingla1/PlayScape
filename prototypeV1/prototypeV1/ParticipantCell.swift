//
//  ParticipantCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 15/01/25.
//

import UIKit

class ParticipantCell: UITableViewCell {

    private let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.textColor = .white
            return label
        }()
        
        private let levelLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
            return label
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    private func setupCell() {
            backgroundColor = .clear
            selectionStyle = .none
            
            // Add subviews and setup constraints
            contentView.addSubview(profileImageView)
            contentView.addSubview(nameLabel)
            contentView.addSubview(levelLabel)
            
            // Setup constraints using NSLayoutConstraint
            profileImageView.translatesAutoresizingMaskIntoConstraints = false
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            levelLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                profileImageView.widthAnchor.constraint(equalToConstant: 40),
                profileImageView.heightAnchor.constraint(equalToConstant: 40),
                
                nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
                nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                
                levelLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
                levelLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
            ])
        }
    
    func configure(name: String, level: Int, joinedDate: String) {
            nameLabel.text = name
            levelLabel.text = "Level \(level). Joined \(joinedDate)"
            profileImageView.image = UIImage(systemName: "person.circle.fill")
        }
    
}
