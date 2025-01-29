//
//  SignUpViewController.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 21/01/25.s
//

import UIKit
class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private let userDataModel = UserDataModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let age = ageTextField.text, !age.isEmpty,
              let location = locationTextField.text, !location.isEmpty,
              let college = collegeTextField.text, !college.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields")
            return
        }
        
        // Store basic info in UserDefaults to pass to next screen
        UserDefaults.standard.set(name, forKey: "tempName")
        UserDefaults.standard.set(email, forKey: "tempEmail")
        UserDefaults.standard.set(age, forKey: "tempAge")
        UserDefaults.standard.set(college, forKey: "tempUniversity")
        
        // Navigate to password screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let passwordVC = storyboard.instantiateViewController(withIdentifier: "PasswordViewController") as? PasswordViewController {
            navigationController?.pushViewController(passwordVC, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
