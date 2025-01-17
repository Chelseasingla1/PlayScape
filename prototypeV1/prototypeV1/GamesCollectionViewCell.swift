//
//  GamesCollectionViewCell.swift
//  avinya_5
//
//  Created by Chelsea Singla on 23/12/24.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var personImage: UIImageView!
    
    
    @IBOutlet weak var goingLabel: UILabel!
    
    
    
    
    @IBOutlet weak var name: UILabel!
    
    
    
    @IBOutlet weak var location: UILabel!
    
    
    @IBOutlet weak var calendar: UILabel!
    
    
    @IBOutlet weak var gameImage: UIImageView!
    
    
    @IBOutlet weak var gameLabel: UILabel!
    
    
    func configure(with data: GameData) {
           // Profile image
           personImage.image = UIImage(named: data.personImage)
           personImage.layer.cornerRadius = 25
           personImage.clipsToBounds = true
           personImage.layer.borderWidth = 2
           personImage.layer.borderColor = UIColor.systemGreen.cgColor
           
           // Attendance info
           let attributedString = NSMutableAttributedString()
           attributedString.append(NSAttributedString(string: "\(data.going) | ",
               attributes: [.foregroundColor: UIColor.white]))
           attributedString.append(NSAttributedString(string: data.mutual,
               attributes: [.foregroundColor: UIColor.systemGreen]))
           goingLabel.attributedText = attributedString
           
           // Name
           name.text = data.personName
        
        name.font = .systemFont(ofSize: 17, weight: .medium)
                name.textColor = .white
                
                // Game type
                gameImage.image = UIImage(systemName: data.gameIcon)
                gameImage.tintColor = .white
                gameLabel.text = data.gameType
                gameLabel.textColor = .white
                
                // Date
               // let calendarIcon = NSTextAttachment()
               // calendarIcon.image = UIImage(systemName: "calendar")?.withTintColor(.white)
               // calendarIcon.bounds = CGRect(x: 0, y: -3, width: 14, height: 14)
                let dateString = NSMutableAttributedString()
                //dateString.append(NSAttributedString(attachment: calendarIcon))
                dateString.append(NSAttributedString(string: " \(data.date)",
                    attributes: [.foregroundColor: UIColor.white]))
                calendar.attributedText = dateString
                
                // Location
               // let locationIcon = NSTextAttachment()
             //   locationIcon.image = UIImage(systemName: "mappin.and.ellipse")?.withTintColor(.white)
             //   locationIcon.bounds = CGRect(x: 0, y: -3, width: 14, height: 14)
        let locationString = NSMutableAttributedString()
              // locationString.append(NSAttributedString(attachment: locationIcon))
             locationString.append(NSAttributedString(string: " \(data.location)",
                attributes: [.foregroundColor: UIColor.white]))
               location.attributedText = locationString
               
               // Cell styling
              // backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
               layer.cornerRadius = 12
           }
        
}
