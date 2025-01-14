//
//  SportCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

class SportCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
        @IBOutlet weak var sportLabel: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupUI()
        }
        
        private func setupUI() {
            contentView.backgroundColor = .systemGray6
            contentView.layer.cornerRadius = 12
            contentView.clipsToBounds = true
        }
    
}
