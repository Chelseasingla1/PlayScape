//
//  EditProfileViewController.swift
//  MyProfile
//
//  Created by Tanishq Malik on 15/01/25.
//

import UIKit

class EditProfileViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
//    func presentImagePickerController() {
//        let imagePickerController = UIImagePickerController()
//        imagePickerController.delegate = self
//        
//        // Choose if the picker allows photos from the photo library or the camera.
//        imagePickerController.sourceType = .photoLibrary // Can change to .camera for direct camera access.
//        
//        // Allow editing the image
//        imagePickerController.allowsEditing = true
//        
//        present(imagePickerController, animated: true, completion: nil)
//    }

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var currentName: String?
    var currentUniversity: String?
    var currentProfileImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfilePhotoTapped))
              // Enable interaction on UIImageView
            profileImageView.addGestureRecognizer(tapGesture)
        
//        profileImageView.isUserInteractionEnabled = true
        
        profileImageView.image = currentProfileImage
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true
        
        nameTextField.text = currentName
        universityTextField.text = currentUniversity

        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeProfilePhotoTapped(_ sender: UIButton) {
        print("Profile photo tapped")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
//        imagePickerController.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
//        presentImagePickerController()
        
        
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let selectedImage = info[.originalImage] as? UIImage {
//            profileImageView.image = selectedImage
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the selected image
        if let selectedImage = info[.editedImage] as? UIImage {
            // Update the profile image view with the selected image
            profileImageView.image = selectedImage
        }
        
        // Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if canceled
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // Validate and pass data back
        if let name = nameTextField.text, let university = universityTextField.text {
            NotificationCenter.default.post(name: NSNotification.Name("ProfileUpdated"), object: nil, userInfo: [
                "name": name,
                "university": university,
                "profileImage": profileImageView.image ?? UIImage()
            ])
            navigationController?.popViewController(animated: true)
        }
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
