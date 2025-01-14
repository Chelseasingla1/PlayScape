//
//  MessageTableViewCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var messageCountLabel: UILabel!
        @IBOutlet weak var timeLabel: UILabel!
        @IBOutlet weak var unreadIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
