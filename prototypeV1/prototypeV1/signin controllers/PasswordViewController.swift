//
//  PasswordViewController.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 21/01/25.
//

import UIKit

class PasswordViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        guard let password = passwordTextField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields")
            return
        }
        
        if password != confirmPassword {
            showAlert(title: "Error", message: "Passwords do not match")
            return
        }
        
        // Store password in UserDefaults temporarily
        UserDefaults.standard.set(password, forKey: "tempPassword")
        
        // Navigate to sports selection screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let sportsVC = storyboard.instantiateViewController(withIdentifier: "SportSelectionViewController") as? SportSelectionViewController {
            navigationController?.pushViewController(sportsVC, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
