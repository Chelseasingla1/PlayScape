//
//  ChatMessageCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let messageBubbleView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 16
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
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
           backgroundColor = .clear
           selectionStyle = .none
           
           addSubview(messageBubbleView)
           messageBubbleView.addSubview(messageLabel)
           
           // Default constraints - will be adjusted based on message type
           NSLayoutConstraint.activate([
               messageBubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
               messageBubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
               messageBubbleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.75),
               
               messageLabel.topAnchor.constraint(equalTo: messageBubbleView.topAnchor, constant: 8),
               messageLabel.bottomAnchor.constraint(equalTo: messageBubbleView.bottomAnchor, constant: -8),
               messageLabel.leadingAnchor.constraint(equalTo: messageBubbleView.leadingAnchor, constant: 12),
               messageLabel.trailingAnchor.constraint(equalTo: messageBubbleView.trailingAnchor, constant: -12)
           ])
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with message: ChatMessage) {
            messageLabel.text = message.content
            
            if message.isFromCurrentUser {
                messageBubbleView.backgroundColor = .systemBlue
                messageLabel.textColor = .white
                messageBubbleView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 48).isActive = true
                messageBubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
            } else {
                messageBubbleView.backgroundColor = .systemGray5
                messageLabel.textColor = .label
                messageBubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
                messageBubbleView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -48).isActive = true
            }
        }

}
