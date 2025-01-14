//
//  SelectedMemberCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class SelectedMemberCell: UITableViewCell {

    private let userImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 20
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    private func setupViews() {
            contentView.addSubview(userImageView)
            contentView.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                userImageView.widthAnchor.constraint(equalToConstant: 40),
                userImageView.heightAnchor.constraint(equalToConstant: 40),
                
                nameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
                nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
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
