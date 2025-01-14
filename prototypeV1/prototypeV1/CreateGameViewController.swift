//
//  CreateGameViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

protocol CreateGameDelegate: AnyObject {
    func gameCreated(sport: String, area: String, date: String, time: String)
}

class CreateGameViewController: UIViewController {

    
    @IBOutlet weak var sportButton: UIButton!
       @IBOutlet weak var areaButton: UIButton!
       @IBOutlet weak var dateButton: UIButton!
       @IBOutlet weak var timeButton: UIButton!
       @IBOutlet weak var activityAccessSegmentControl: UISegmentedControl!
       @IBOutlet weak var advancedSettingsButton: UIButton!
       @IBOutlet weak var createGameButton: UIButton!
        
    
    weak var delegate: CreateGameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInitialButtonStates()
    }
    

    private func setupUI() {
            title = "Create Game"
            createGameButton.backgroundColor = .systemGreen
            createGameButton.layer.cornerRadius = 12
        createGameButton.isEnabled = false
        
            // Setup navigation items
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        
        [sportButton, areaButton, dateButton, timeButton].forEach { button in
                    button?.layer.cornerRadius = 8
                    button?.layer.borderWidth = 1
                    button?.layer.borderColor = UIColor.systemGray4.cgColor
                    button?.contentHorizontalAlignment = .left
            button?.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
                }
                
                // Setup initial button states
                setupInitialButtonStates()
        
        }
        
        // MARK: - Actions
        @IBAction func sportButtonTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let sportVC = storyboard.instantiateViewController(withIdentifier: "SportViewController") as? SportViewController {
                navigationController?.pushViewController(sportVC, animated: true)
            }
        }
    
    private func setupInitialButtonStates() {
           // Set initial titles with placeholder style
           sportButton.setTitle("Select Sport", for: .normal)
           areaButton.setTitle("Select Area", for: .normal)
           dateButton.setTitle("Select Date", for: .normal)
           timeButton.setTitle("Select Time", for: .normal)
           
           [sportButton, areaButton, dateButton, timeButton].forEach { button in
               button?.setTitleColor(.systemGray, for: .normal)
           }
       }
    
    private func updateButtonState(_ button: UIButton, withSelection text: String) {
           button.setTitle(text, for: .normal)
           button.setTitleColor(.systemBlue, for: .normal)
           button.backgroundColor = .systemBlue.withAlphaComponent(0.1)
           button.layer.borderColor = UIColor.systemBlue.cgColor
           
           // Add checkmark image
           let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
           let checkmark = UIImage(systemName: "checkmark.circle.fill", withConfiguration: imageConfig)
           button.setImage(checkmark, for: .normal)
           button.tintColor = .systemBlue
           button.semanticContentAttribute = .forceRightToLeft
           button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
           
           updateCreateGameButton()
       }
    
    
    private func updateCreateGameButton() {
           let isAllSelected = [sportButton, areaButton, dateButton, timeButton].allSatisfy { button in
               let title = button?.title(for: .normal)
               return title != "Select Sport" && title != "Select Area" &&
                      title != "Select Date" && title != "Select Time"
           }
           
           createGameButton.backgroundColor = isAllSelected ? .systemGreen : .systemGray4
           createGameButton.isEnabled = isAllSelected
       }
    
    
    @IBAction func areaButtonTapped(_ sender: UIButton) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let areaVC = storyboard.instantiateViewController(withIdentifier: "AreaViewController") as? AreaViewController {
                navigationController?.pushViewController(areaVC, animated: true)
            }
        }
        
        @IBAction func createGameButtonTapped(_ sender: UIButton) {
            // Handle create game
            
            let sport = sportButton.title(for: .normal) ?? ""
                let area = areaButton.title(for: .normal) ?? ""
                let date = dateButton.title(for: .normal) ?? ""
                let time = timeButton.title(for: .normal) ?? ""
                
                delegate?.gameCreated(sport: sport, area: area, date: date, time: time)
                dismiss(animated: true)
        }
        
        @objc private func cancelTapped() {
            dismiss(animated: true)
        }
        
        @objc private func doneTapped() {
            // Handle done
            createGameButtonTapped(createGameButton)
        }
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let dateVC = storyboard.instantiateViewController(withIdentifier: "DateViewController") as? DateViewController {
//            dateVC.delegate = self
//            navigationController?.pushViewController(dateVC, animated: true)
//        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTimeViewController":
            if let timeVC = segue.destination as? TimeViewController {
                timeVC.delegate = self
            }
            
        case "showDateViewController":
            if let dateVC = segue.destination as? DateViewController {
                dateVC.delegate = self
            }
            
        default:
            break
        }
    }
    
}


extension CreateGameViewController: DateViewControllerDelegate {
    func updateDate(_ date: String) {
        dateButton.setTitle(date, for: .normal)
        dateButton.setTitleColor(.systemRed, for: .normal)
        updateButtonState(dateButton, withSelection: date)
    }
}


extension CreateGameViewController: TimeViewControllerDelegate {
    func updateTime(_ timeSlot: String) {
        timeButton.setTitle(timeSlot, for: .normal)
        timeButton.setTitleColor(.systemRed, for: .normal)
        updateButtonState(timeButton, withSelection: timeSlot)
    }
}

//extension CreateGameViewController: SportViewControllerDelegate {
//    func sportSelected(_ sport: String) {
//        updateButtonState(sportButton, withSelection: sport)
//    }
//}
//
//extension CreateGameViewController: AreaViewControllerDelegate {
//    func areaSelected(_ area: String) {
//        updateButtonState(areaButton, withSelection: area)
//    }
//}
