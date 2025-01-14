//
//  MessageViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit


class MessageViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var segmentedControl: UISegmentedControl!
        @IBOutlet weak var tableView: UITableView!
        
        // MARK: - Properties
    
        private var messages: [Message] = [
            Message(userName: "Alex Garrison", messageCount: 4, timeAgo: "6m", userImage: UIImage(named: "person")),
            Message(userName: "Alex Garrison", messageCount: 4, timeAgo: "12m", userImage: UIImage(named: "profile2")),
            Message(userName: "Badminton Players", messageCount: 4, timeAgo: "2 days ago", userImage: UIImage(named: "badminton"))
        ]
        
        private var filteredMessages: [Message] = []
    
        private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChat" {
            if let chatVC = segue.destination as? ChatViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                let message = isSearching ? filteredMessages[indexPath.row] : messages[indexPath.row]
                chatVC.userName = message.userName
                chatVC.userImage = message.userImage
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MessageViewController: viewWillAppear, messages count:", messages.count)
        tableView.reloadData()
    }
    
    // MARK: - UI Setup
      private func setupUI() {
          // Navigation setup
          title = "Network"
          navigationItem.rightBarButtonItem = UIBarButtonItem(
              image: UIImage(systemName: "person.circle"),
              style: .plain,
              target: self,
              action: #selector(profileTapped)
          )
          
          let profileButton = UIBarButtonItem(
                 image: UIImage(systemName: "person.circle"),
                 style: .plain,
                 target: self,
                 action: #selector(profileTapped)
             )
          
          let addFriendsButton = UIBarButtonItem(
                 image: UIImage(systemName: "person.badge.plus"),
                 style: .plain,
                 target: self,
                 action: #selector(findFriendsTapped)
             )
          
          navigationItem.rightBarButtonItems = [profileButton, addFriendsButton]
          
          // SearchBar setup
          searchBar.delegate = self
          searchBar.placeholder = "Search"
          
          // SegmentedControl setup
          segmentedControl.addTarget(
              self,
              action: #selector(segmentChanged),
              for: .valueChanged
          )
          
          // TableView setup
          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorStyle = .none
      }
      
      // MARK: - Actions
      @objc private func profileTapped() {
          // Handle profile button tap
          print("Profile tapped")
      }
      
      @objc private func segmentChanged(_ sender: UISegmentedControl) {
          // Handle segment change
          if sender.selectedSegmentIndex == 0 {
              print("Messages selected")
          } else {
              print("Requests selected")
          }
      }
    
//    @objc func findFriendsTapped(_ sender: Any) {
//        if let findFriendsVC = storyboard?.instantiateViewController(withIdentifier: "FindFriendsViewController") as? FindFriendsViewController {
//            navigationController?.pushViewController(findFriendsVC, animated: true)
//        }
//    }
//    
    // Add to MessageViewController
    @IBAction func findFriendsTapped(_ sender: Any) {
        if let findFriendsVC = storyboard?.instantiateViewController(withIdentifier: "FindFriendsViewController") as? FindFriendsViewController {
            navigationController?.pushViewController(findFriendsVC, animated: true)
        }
    }
    
  }

  // MARK: - UITableViewDelegate & UITableViewDataSource
  extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return isSearching ? filteredMessages.count : messages.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(
              withIdentifier: "MessageCell",
              for: indexPath
          ) as? MessageTableViewCell else {
              return UITableViewCell()
          }
          
          let message = isSearching ? filteredMessages[indexPath.row] : messages[indexPath.row]
          
          // Configure cell
          cell.userImageView.image = message.userImage
          cell.nameLabel.text = message.userName
          cell.messageCountLabel.text = "\(message.messageCount)+ new messages"
          cell.timeLabel.text = message.timeAgo
          
          return cell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//          tableView.deselectRow(at: indexPath, animated: true)
//              
//              let message = isSearching ? filteredMessages[indexPath.row] : messages[indexPath.row]
//              
//              // Get the chat view controller from storyboard
//              if let chatVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController {
//                  // Pass the data
//                  chatVC.userName = message.userName
//                  chatVC.userImage = message.userImage
//                  
//                  // Push the view controller
//                  navigationController?.pushViewController(chatVC, animated: true)
//              }
      }
  }

  // MARK: - UISearchBarDelegate
  extension MessageViewController: UISearchBarDelegate {
      
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchText.isEmpty {
              isSearching = false
              filteredMessages = []
          } else {
              isSearching = true
              filteredMessages = messages.filter { message in
                  message.userName.lowercased().contains(searchText.lowercased())
              }
          }
          tableView.reloadData()
      }
      
      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
          searchBar.showsCancelButton = true
      }
      
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchBar.text = ""
          searchBar.showsCancelButton = false
          searchBar.endEditing(true)
          isSearching = false
          tableView.reloadData()
      }
    
}

extension MessageViewController: GroupCreationDelegate {
    func didCreateGroup(_ group: Message) {
//        print("New group created:", group.userName)
//        messages.insert(group, at: 0)
//        tableView.reloadData()
        
        print("MessageViewController: didCreateGroup called with group:", group.userName)
                messages.insert(group, at: 0)
                print("MessageViewController: messages count after insert:", messages.count)
                tableView.reloadData()
    }
}

extension MessageViewController {
    func addNewFriend(_ user: User) {
        let newMessage = Message(
            userName: user.name,
            messageCount: 0,
            timeAgo: "Just now",
            userImage: user.profileImage
        )
        messages.insert(newMessage, at: 0)
        tableView.reloadData()
    }
}


struct Message {
    let userName: String
    let messageCount: Int
    let timeAgo: String
    let userImage: UIImage?
    
    static func == (lhs: Message, rhs: Message) -> Bool {
            return lhs.userName == rhs.userName &&
                   lhs.messageCount == rhs.messageCount &&
                   lhs.timeAgo == rhs.timeAgo
        }
}
