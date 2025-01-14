//
//  InterestCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 13/12/24.
//

import UIKit

class InterestCell: UICollectionViewCell {
    private let titleLabel = UILabel()
       private let imageView = UIImageView()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           setupViews()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       private func setupViews() {
           contentView.backgroundColor = .systemGray6
           contentView.layer.cornerRadius = 12
           
           [imageView, titleLabel].forEach {
               $0.translatesAutoresizingMaskIntoConstraints = false
               contentView.addSubview($0)
           }
           
           imageView.contentMode = .scaleAspectFit
           titleLabel.textAlignment = .center
           
           NSLayoutConstraint.activate([
                     imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                     imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                     imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                     imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
                     
                     titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
                     titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                     titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
                 ])
             }
             
             func configure(with title: String) {
                 titleLabel.text = title
                 imageView.image = UIImage(systemName: "sportscourt.fill")
             }
}
