//
//  FindFriendsViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class FindFriendsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newGroupButton: UIButton!
    
    
    private var users: [User] = [
        User(id: "1", name: "Alex Garrison", profileImage: UIImage(named: "person"), mutualFriends: 2),
        User(id: "2", name: "Aron Harridson", profileImage: UIImage(named: "person") , mutualFriends: 2),
        User(id: "3", name: "Brio Garrison", profileImage: UIImage(named: "person") , mutualFriends: 2),
        User(id: "4", name: "Billie Garrison", profileImage: UIImage(named: "person") , mutualFriends: 2)
    ]
    
    private var filteredUsers: [User] = []
    private var sectionTitles: [String] = []
    private var usersBySection: [String: [User]] = [:]
    private var selectedUsersForGroup: [User] = []
    private var isGroupCreationMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        organizeUsersBySection()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        title = "My Friends"
        
        searchBar.delegate = self
        searchBar.placeholder = "Find"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        
        newGroupButton.backgroundColor = .systemBlue
        newGroupButton.layer.cornerRadius = 8
        newGroupButton.setTitle("New Group", for: .normal)
        newGroupButton.setTitleColor(.white, for: .normal)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Find Players",
            style: .plain,
            target: self,
            action: #selector(findPlayersTapped)
        )
    }
    
    
    private func organizeUsersBySection() {
        usersBySection.removeAll()
        sectionTitles.removeAll()
        
        let users = searchBar.text?.isEmpty ?? true ? self.users : filteredUsers
        
        for user in users {
            let firstLetter = String(user.name.prefix(1).uppercased())
            if usersBySection[firstLetter] == nil {
                usersBySection[firstLetter] = []
            }
            usersBySection[firstLetter]?.append(user)
        }
        
        sectionTitles = Array(usersBySection.keys).sorted()
        
        for key in usersBySection.keys {
            usersBySection[key]?.sort { $0.name < $1.name }
        }
    }
    
    @objc private func nextTapped() {
        guard !selectedUsersForGroup.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please select at least one member", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        if let createGroupVC = storyboard?.instantiateViewController(withIdentifier: "CreateGroupViewController") as? CreateGroupViewController {
            // Find the MessageViewController from the navigation stack
            if let messageVC = navigationController?.viewControllers.first(where: { $0 is MessageViewController }) as? MessageViewController {
                print("Found MessageViewController, setting delegate")
                createGroupVC.delegate = messageVC
            } else {
                print("Could not find MessageViewController")
            }
            createGroupVC.selectedUsers = selectedUsersForGroup
            navigationController?.pushViewController(createGroupVC, animated: true)
        }
    }
    
    
    @objc private func findPlayersTapped() {
        if let findPlayersVC = storyboard?.instantiateViewController(withIdentifier: "FindPlayersViewController") as? FindPlayersViewController {
            navigationController?.pushViewController(findPlayersVC, animated: true)
        }
    }
    
    
    
    @IBAction func newGroupTapped(_ sender: Any) {
        isGroupCreationMode = true
        tableView.allowsMultipleSelection = true
        
        // Update UI for group creation mode
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Next",
            style: .done,
            target: self,
            action: #selector(nextTapped)
        )
        
        title = "Add members"
        
        if let createGroupVC = storyboard?.instantiateViewController(withIdentifier: "CreateGroupViewController") as? CreateGroupViewController {
            // Important: Set the delegate before pushing
            if let messageVC = navigationController?.viewControllers.first as? MessageViewController {
                createGroupVC.delegate = messageVC
            }
            navigationController?.pushViewController(createGroupVC, animated: true)
        }
    }
    
}
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    extension FindFriendsViewController: UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return sectionTitles.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            let sectionTitle = sectionTitles[section]
            return usersBySection[sectionTitle]?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTitles[section]
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell
            
            let sectionTitle = sectionTitles[indexPath.section]
            if let users = usersBySection[sectionTitle] {
                let user = users[indexPath.row]
                cell.configure(with: user)
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
            if isGroupCreationMode {
                let sectionTitle = sectionTitles[indexPath.section]
                guard let users = usersBySection[sectionTitle] else { return }
                let deselectedUser = users[indexPath.row]
                
                if let index = selectedUsersForGroup.firstIndex(where: { $0.id == deselectedUser.id }) {
                    selectedUsersForGroup.remove(at: index)
                }
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // tableView.deselectRow(at: indexPath, animated: true)
            let sectionTitle = sectionTitles[indexPath.section]
            guard let users = usersBySection[sectionTitle] else { return }
            let selectedUser = users[indexPath.row]
            
            if isGroupCreationMode {
                selectedUsersForGroup.append(selectedUser)
                // Don't deselect the row in group creation mode
            } else {
                tableView.deselectRow(at: indexPath, animated: true)
                // Navigate to chat
                if let chatVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
                    chatVC.userName = selectedUser.name
                    chatVC.userImage = selectedUser.profileImage
                    navigationController?.pushViewController(chatVC, animated: true)
                }
            }
            
        }
    }
    
    // MARK: - UISearchBarDelegate
    extension FindFriendsViewController: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredUsers = users
            } else {
                filteredUsers = users.filter { user in
                    user.name.lowercased().contains(searchText.lowercased())
                }
            }
            organizeUsersBySection()
            tableView.reloadData()
        }
    }
    

//extension FindFriendsViewController: GroupCreationDelegate {
//    func didCreateGroup(_ group: Message) {
//        // This will be called when a group is created
//        // You can handle the new group here if needed
//        navigationController?.popViewController(animated: true)
//    }
//}
