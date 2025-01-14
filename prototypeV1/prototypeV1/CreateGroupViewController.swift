//
//  CreateGroupViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

protocol GroupCreationDelegate: AnyObject {
    func didCreateGroup(_ group: Message)
}

class CreateGroupViewController: UIViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
       
    @IBOutlet weak var selectedMembersTableView: UITableView!
        @IBOutlet weak var availableFriendsTableView: UITableView!
        
    
       var selectedUsers: [User] = []
    var availableFriends: [User] = [
        User(id: "1", name: "Alex Garrison", profileImage: UIImage(named: "person"), mutualFriends: 1),
            User(id: "2", name: "Aron Harridson", profileImage: UIImage(named: "person") , mutualFriends: 1),
            User(id: "3", name: "Brio Garrison", profileImage: UIImage(named: "person"), mutualFriends: 1),
            User(id: "4", name: "Billie Garrison", profileImage: UIImage(named: "person"), mutualFriends: 1)
        ]
    
       weak var delegate: GroupCreationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI() {
            title = "New Group"
            
            // Navigation bar setup
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Back",
                style: .plain,
                target: self,
                action: #selector(backTapped)
            )
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Create",
                style: .done,
                target: self,
                action: #selector(createTapped)
            )
            
            // Setup text field
            groupNameTextField.placeholder = "Group Name"
            groupNameTextField.becomeFirstResponder()
            
            // Setup table view
        
        selectedMembersTableView.delegate = self
              selectedMembersTableView.dataSource = self
              selectedMembersTableView.register(SelectedMemberCell.self, forCellReuseIdentifier: "SelectedMemberCell")
              
              // Setup Available Friends TableView
              availableFriendsTableView.delegate = self
              availableFriendsTableView.dataSource = self
              availableFriendsTableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        
        }
        
        @objc private func backTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        @objc private func createTapped() {
            guard let groupName = groupNameTextField.text, !groupName.isEmpty else {
                // Show alert for empty group name
                let alert = UIAlertController(title: "Error", message: "Please enter a group name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }
            
            print("Creating group with name:", groupName)
            
            // Create group message
            let groupMessage = Message(
                userName: groupName,
                messageCount: 0,
                timeAgo: "Just now",
                userImage: UIImage(named: "group_placeholder")
            )
            
            // Check if delegate exists
            if let delegate = delegate {
                    print("Delegate exists, calling didCreateGroup")
                    delegate.didCreateGroup(groupMessage)
                } else {
                    print("Warning: delegate is nil")
                    // Try to find MessageViewController from navigation stack
                    if let messageVC = navigationController?.viewControllers.first(where: { $0 is MessageViewController }) as? MessageViewController {
                        print("Found MessageViewController, setting delegate and calling didCreateGroup")
                        self.delegate = messageVC
                        messageVC.didCreateGroup(groupMessage)
                    } else {
                        print("Could not find MessageViewController in navigation stack")
                    }
                }
            
            // Notify delegate
         //   delegate?.didCreateGroup(groupMessage)
            
            // Dismiss all the way back to messages
            navigationController?.popToRootViewController(animated: true)
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


extension CreateGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == selectedMembersTableView {
            return selectedUsers.count
        } else if tableView == availableFriendsTableView {
            return availableFriends.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == selectedMembersTableView {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "SelectedMemberCell",
                for: indexPath
            ) as! SelectedMemberCell
            let user = selectedUsers[indexPath.row]
            cell.configure(with: user)
            return cell
        } else if tableView == availableFriendsTableView {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "UserCell",
                for: indexPath
            ) as! UserTableViewCell
            let user = availableFriends[indexPath.row]
            cell.configure(with: user)
            cell.accessoryType = selectedUsers.contains(where: { $0.id == user.id }) ? .checkmark : .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == availableFriendsTableView {
            let selectedFriend = availableFriends[indexPath.row]
            
            if let index = selectedUsers.firstIndex(where: { $0.id == selectedFriend.id }) {
                // Remove if already selected
                selectedUsers.remove(at: index)
            } else {
                // Add if not selected
                selectedUsers.append(selectedFriend)
            }
            
            // Reload both table views
            selectedMembersTableView.reloadData()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == selectedMembersTableView && editingStyle == .delete {
            selectedUsers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            availableFriendsTableView.reloadData()
        }
    }
}
