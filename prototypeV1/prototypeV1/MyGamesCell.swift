//
//  MyGamesCell.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 13/12/24.
//

import UIKit

class MyGamesCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let levelLabel = UILabel()
    private let viewButton = UIButton()
    private let calendarButton = UIButton()
    
    var viewButtonTapped: (() -> Void)?
    var calendarButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // First, add ALL subviews to contentView
        [titleLabel, locationLabel, dateLabel, levelLabel, viewButton, calendarButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        // Configure UI elements
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 12
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        locationLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 14)
        levelLabel.font = .systemFont(ofSize: 12)
        levelLabel.text = "Beginner"
        levelLabel.backgroundColor = .systemRed
        levelLabel.textColor = .white
        levelLabel.textAlignment = .center
        levelLabel.layer.cornerRadius = 4
        levelLabel.clipsToBounds = true
        
        viewButton.setTitle("VIEW", for: .normal)
        viewButton.backgroundColor = .systemGreen
        viewButton.setTitleColor(.white, for: .normal)
        viewButton.layer.cornerRadius = 8
        viewButton.addTarget(self, action: #selector(viewButtonPressed), for: .touchUpInside)
        
        calendarButton.setTitle("VIEW MY CALENDAR", for: .normal)
        calendarButton.setTitleColor(.systemRed, for: .normal)
        calendarButton.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: levelLabel.leadingAnchor, constant: -8),
            
            levelLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            levelLabel.widthAnchor.constraint(equalToConstant: 70),
            levelLabel.heightAnchor.constraint(equalToConstant: 24),
            
            locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: -8),
            
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: viewButton.leadingAnchor, constant: -8),
            
            viewButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            viewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            viewButton.widthAnchor.constraint(equalToConstant: 70),
            viewButton.heightAnchor.constraint(equalToConstant: 32),
            
            calendarButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            calendarButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            calendarButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    @objc private func viewButtonPressed() {
        viewButtonTapped?()
    }
    
    @objc private func calendarButtonPressed() {
        calendarButtonTapped?()
    }
    
    func configure(title: String, location: String, date: String) {
        titleLabel.text = title
        locationLabel.text = location
        dateLabel.text = date
    }
}
