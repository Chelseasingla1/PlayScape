//
//  UserTableViewCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    private let userImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 25
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let chatButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "message.circle.fill"), for: .normal)
            button.tintColor = .systemBlue
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupViews()
        }
    
    private func setupViews() {
           contentView.addSubview(userImageView)
           contentView.addSubview(nameLabel)
           contentView.addSubview(chatButton)
           
           NSLayoutConstraint.activate([
               userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
               userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               userImageView.widthAnchor.constraint(equalToConstant: 50),
               userImageView.heightAnchor.constraint(equalToConstant: 50),
               
               nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
               nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               
               chatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
               chatButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               chatButton.widthAnchor.constraint(equalToConstant: 30),
               chatButton.heightAnchor.constraint(equalToConstant: 30)
           ])
       }
    
    func configure(with user: User) {
            userImageView.image = user.profileImage
            nameLabel.text = user.name
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
