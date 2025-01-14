//
//  MyGamesCollectionViewCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

class MyGamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
       @IBOutlet weak var titleLabel: UILabel!
       @IBOutlet weak var locationLabel: UILabel!
       @IBOutlet weak var dateLabel: UILabel!
       @IBOutlet weak var levelLabel: UILabel!
       @IBOutlet weak var viewCalendarButton: UIButton!
       
       @IBAction func viewCalendarTapped(_ sender: UIButton) {
           // Handle calendar action
       }
    
}
