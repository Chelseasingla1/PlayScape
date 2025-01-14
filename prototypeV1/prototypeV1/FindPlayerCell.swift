//
//  FindPlayerCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

protocol FindPlayerCellDelegate: AnyObject {
    func didTapAddButton(for user: User)
}


class FindPlayerCell: UITableViewCell {

    weak var delegate: FindPlayerCellDelegate?
        private var user: User?
        
        private let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 25
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let mutualFriendsLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .secondaryLabel
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let addButton: UIButton = {
            let button = UIButton()
            button.setTitle("+ Add", for: .normal)
            button.backgroundColor = .systemYellow
            button.layer.cornerRadius = 15
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
           contentView.addSubview(profileImageView)
           contentView.addSubview(nameLabel)
           contentView.addSubview(mutualFriendsLabel)
           contentView.addSubview(addButton)
           
           NSLayoutConstraint.activate([
               profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               profileImageView.widthAnchor.constraint(equalToConstant: 50),
               profileImageView.heightAnchor.constraint(equalToConstant: 50),
               
               nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
               nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
               nameLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -12),
               
               mutualFriendsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
               mutualFriendsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
               mutualFriendsLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
               
               addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               addButton.widthAnchor.constraint(equalToConstant: 70),
               addButton.heightAnchor.constraint(equalToConstant: 30)
           ])
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            }
            
            func configure(with user: User) {
                self.user = user
                profileImageView.image = user.profileImage
                nameLabel.text = user.name
                mutualFriendsLabel.text = "\(user.mutualFriends)+ MUTUAL FRIENDS"
            }
            
            @objc private func addButtonTapped() {
                if let user = user {
                    delegate?.didTapAddButton(for: user)
                }
            }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
