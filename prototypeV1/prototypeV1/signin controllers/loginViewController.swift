import UIKit
class loginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private let userDataModel = UserDataModel.shared
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        // Check if email is empty
        if let email = emailTextField.text, email.isEmpty {
                    showAlert(title: "Error", message: "Please enter your email")
                    return
                }
                
                // Check if password is empty
                if let password = passwordTextField.text, password.isEmpty {
                    showAlert(title: "Error", message: "Please enter your password")
                    return
                }
                
                guard let email = emailTextField.text,
                      let password = passwordTextField.text else {
                    return
                }
                
                // Try to login using UserDataModel
                if userDataModel.login(email: email, password: password) {
                    // Login successful, navigate to next screen
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let myHubVC = storyboard.instantiateViewController(withIdentifier: "tableview")
                    navigationController?.pushViewController(myHubVC, animated: true)
                } else {
                    // Login failed
                    showAlert(title: "Error", message: "Invalid email or password")
                }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
