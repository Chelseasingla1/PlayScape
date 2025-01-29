import UIKit

class SkillLevelViewController: UIViewController {
    @IBOutlet weak var beginnerButton: UIButton!
    @IBOutlet weak var amateurButton: UIButton!
    @IBOutlet weak var intermediateButton: UIButton!
    @IBOutlet weak var advancedButton: UIButton!
    @IBOutlet weak var professionalButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    private let userDataModel = UserDataModel.shared
    private var selectedSkillLevel: SkillLevel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkillButtons()
    }
    
    private func setupSkillButtons() {
        // Set up tag values to match skill levels
        beginnerButton.tag = 0     // Maps to SkillLevel.beginner
        amateurButton.tag = 1      // Maps to SkillLevel.amateur
        intermediateButton.tag = 2  // Maps to SkillLevel.intermediate
        advancedButton.tag = 3     // Maps to SkillLevel.advanced
        professionalButton.tag = 4  // Maps to SkillLevel.professional
        
        [beginnerButton, amateurButton, intermediateButton, advancedButton, professionalButton].forEach { button in
            button?.layer.cornerRadius = 8
            button?.layer.borderWidth = 1
            button?.layer.borderColor = UIColor.white.cgColor
            button?.backgroundColor = .clear
        }
    }
    
    @IBAction func skillButtonTapped(_ sender: UIButton) {
        // Reset all buttons
        [beginnerButton, amateurButton, intermediateButton, advancedButton, professionalButton].forEach { button in
            button?.backgroundColor = .clear
            button?.isSelected = false
        }
        
        // Select tapped button
        sender.isSelected = true
        sender.backgroundColor = .systemBlue
        
        // Map button tag to skill level
        switch sender.tag {
        case 0: selectedSkillLevel = .beginner
        case 1: selectedSkillLevel = .amateur
        case 2: selectedSkillLevel = .intermediate
        case 3: selectedSkillLevel = .advanced
        case 4: selectedSkillLevel = .professional
        default: break
        }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        guard let skillLevel = selectedSkillLevel else {
            showAlert(title: "Error", message: "Please select your skill level")
            return
        }
        
        // Retrieve all temporary stored data
        guard let name = UserDefaults.standard.string(forKey: "tempName"),
              let email = UserDefaults.standard.string(forKey: "tempEmail"),
              let age = UserDefaults.standard.string(forKey: "tempAge"),
              let university = UserDefaults.standard.string(forKey: "tempUniversity"),
              let password = UserDefaults.standard.string(forKey: "tempPassword"),
              let sportStrings = UserDefaults.standard.stringArray(forKey: "tempSports"),
              let sports = sportStrings.map({ Sport(rawValue: $0) }) as? [Sport] else {
            showAlert(title: "Error", message: "Something went wrong")
            return
        }
        
        // Create sports interests array
        let sportsInterests = sports.map { SportInterest(sport: $0, skillLevel: skillLevel) }
        
        // Create user account
        let success = userDataModel.signup(
            name: name,
            email: email,
            password: password,
            dateOfBirth: age,
            university: university
        )
        
        if success {
            // Add sports interests
            for interest in sportsInterests {
                _ = userDataModel.updateSportsInterests(selectedSport: interest.sport, skillLevel: interest.skillLevel)
            }
            
            // Clear temporary data
            clearTemporaryData()
            
            // Navigate to main app screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainVC = storyboard.instantiateViewController(withIdentifier: "loginViewController")
            navigationController?.pushViewController(mainVC, animated: true)
        } else {
            showAlert(title: "Error", message: "Failed to create account")
        }
    }
    
    private func clearTemporaryData() {
        UserDefaults.standard.removeObject(forKey: "tempName")
        UserDefaults.standard.removeObject(forKey: "tempEmail")
        UserDefaults.standard.removeObject(forKey: "tempAge")
        UserDefaults.standard.removeObject(forKey: "tempUniversity")
        UserDefaults.standard.removeObject(forKey: "tempPassword")
        UserDefaults.standard.removeObject(forKey: "tempSports")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
