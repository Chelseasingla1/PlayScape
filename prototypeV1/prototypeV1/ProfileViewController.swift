//
//  ProfileViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 16/01/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var winsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set profile image
        profileImageView.image = UIImage(named: "profile_picture")
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        
        // Set labels
        nameLabel.text = "Alex Garrison"
        universityLabel.text = "Chitkara University"
        
        emailLabel.text = "alex.garrison@gmail.com"
        birthdateLabel.text = "Sep 22, 2002"
        schoolLabel.text = "Chitkara University"
        sportsLabel.text = "Cricket, Soccer"
        levelLabel.text = "Beginner - Level 2"
        winsLabel.text = "2 wins"
        
        // Set icons
        if let emailIcon = UIImage(systemName: "envelope") {
            replaceIcon(of: emailLabel, with: emailIcon)
        }
        
        if let calendarIcon = UIImage(systemName: "calendar") {
            replaceIcon(of: birthdateLabel, with: calendarIcon)
        }
        
        if let schoolIcon = UIImage(systemName: "graduationcap") {
            replaceIcon(of: schoolLabel, with: schoolIcon)
        }
        
        if let sportsIcon = UIImage(systemName: "sportscourt") {
            replaceIcon(of: sportsLabel, with: sportsIcon)
        }
        
        if let levelIcon = UIImage(systemName: "rosette") {
            replaceIcon(of: levelLabel, with: levelIcon)
        }
        
        if let winsIcon = UIImage(systemName: "trophy") {
            replaceIcon(of: winsLabel, with: winsIcon)
        }
    }
    
    func replaceIcon(of label: UILabel, with icon: UIImage) {
        let attachment = NSTextAttachment()
        attachment.image = icon
        
        let attachmentString = NSAttributedString(attachment: attachment)
        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentString)
        
        let iconString = NSAttributedString(string: " ")
        mutableAttributedString.append(iconString)
        
        let textString = NSAttributedString(string: label.text!)
        mutableAttributedString.append(textString)
        
        label.attributedText = mutableAttributedString
    }
}
