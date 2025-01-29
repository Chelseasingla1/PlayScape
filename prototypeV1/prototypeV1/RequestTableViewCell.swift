//
//  RequestTableViewCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 20/01/25.
//

import UIKit

protocol RequestCellDelegate: AnyObject {
    func didAcceptRequest(at index: Int)
    func didRejectRequest(at index: Int)
}


class RequestTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    weak var delegate: RequestCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        // Configure user image
        userImageView.layer.cornerRadius = 25
        userImageView.clipsToBounds = true
        userImageView.contentMode = .scaleAspectFill
        
        // Configure name label
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        
        // Configure time label
        timeLabel.font = .systemFont(ofSize: 14)
        timeLabel.textColor = .secondaryLabel
        
        // Configure accept button
        acceptButton.backgroundColor = .systemGreen
        acceptButton.layer.cornerRadius = 15
        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.setTitleColor(.white, for: .normal)
        acceptButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        // Configure reject button
        rejectButton.backgroundColor = .systemRed
        rejectButton.layer.cornerRadius = 15
        rejectButton.setTitle("Reject", for: .normal)
        rejectButton.setTitleColor(.white, for: .normal)
        rejectButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    @IBAction func acceptTapped(_ sender: UIButton) {
        delegate?.didAcceptRequest(at: tag)
    }
    
    @IBAction func rejectTapped(_ sender: UIButton) {
        delegate?.didRejectRequest(at: tag)
    }
}
