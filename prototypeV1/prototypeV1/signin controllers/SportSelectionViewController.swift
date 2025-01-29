//
//  SportSelectionViewController.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 21/01/25.
//

import UIKit

class SportSelectionViewController: UIViewController {
    @IBOutlet weak var footballButton: UIButton!
    @IBOutlet weak var basketballButton: UIButton!
    @IBOutlet weak var cricketButton: UIButton!
    @IBOutlet weak var volleyballButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    private var selectedSports: Set<Sport> = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }
        
    private func setupButtons() {
            // Set up tag values to match sports
        footballButton.tag = 0    // Maps to Sport.football
        basketballButton.tag = 1  // Maps to Sport.basketball
        cricketButton.tag = 2     // Maps to Sport.cricket
        volleyballButton.tag = 3  // Maps to Sport.volleyball
            
            // Configure button appearance
        [footballButton, basketballButton, cricketButton, volleyballButton].forEach { button in
                button?.layer.cornerRadius = 8
                button?.layer.borderWidth = 1
                button?.layer.borderColor = UIColor.white.cgColor
                button?.backgroundColor = .clear
            }
        }
        
        @IBAction func sportButtonTapped(_ sender: UIButton) {
            // Map button tag to Sport enum
            let sport: Sport
            switch sender.tag {
            case 0: sport = .football
            case 1: sport = .basketball
            case 2: sport = .cricket
            case 3: sport = .volleyball
            default: return
            }
            
            // Toggle selection
            sender.isSelected = !sender.isSelected
            sender.backgroundColor = sender.isSelected ? .systemBlue : .clear
            
            if sender.isSelected {
                selectedSports.insert(sport)
            } else {
                selectedSports.remove(sport)
            }
        }
        
        @IBAction func continueButtonTapped(_ sender: UIButton) {
            guard !selectedSports.isEmpty else {
                showAlert(title: "Error", message: "Please select at least one sport")
                return
            }
            
            // Store selected sports temporarily
            UserDefaults.standard.set(Array(selectedSports.map { $0.rawValue }), forKey: "tempSports")
            
            // Navigate to skill level screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let skillVC = storyboard.instantiateViewController(withIdentifier: "SkillLevelViewController") as? SkillLevelViewController {
                navigationController?.pushViewController(skillVC, animated: true)
            }
        }
        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

}
