//
//  loginViewController.swift
//  prototypeV1
//
//  Created by Taksh Joshi on 10/12/24.
//

import UIKit

class loginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func submitTapped(_ sender: UIButton) {
//        guard let email = emailTextField.text, !email.isEmpty,
//                      let password = passwordTextField.text, !password.isEmpty else {
//                    showAlert(title: "Error", message: "Please fill in all fields.")
//                    return
//                }
//
//                loginUser(email: email, password: password) { success, errorMessage in
//                    DispatchQueue.main.async {
//                        if success {
//                            self.showAlert(title: "Success", message: "Login successful!")
//                            // Navigate to the main app screen or next view controller
//                            // Example: self.performSegue(withIdentifier: "goToMainApp", sender: nil)
//                        } else {
//                            self.showAlert(title: "Error", message: errorMessage ?? "Login failed.")
//                        }
//                    }
//                }
//    }
    func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
