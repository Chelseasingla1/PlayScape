//
//  FindPlayersViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

class FindPlayersViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var tableView: UITableView!
        
        private var players: [User] = [
            User(id: "5", name: "Aron Harridson", profileImage: UIImage(named: "person"), mutualFriends: 4),
            User(id: "6", name: "Alex Garrison", profileImage: UIImage(named: "person"), mutualFriends: 4),
            User(id: "7", name: "Badminton Players", profileImage: UIImage(named: "person"), mutualFriends: 4)
        ]
        private var filteredPlayers: [User] = []
        private var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
            title = "Find Players"
            
            searchBar.delegate = self
            searchBar.placeholder = "Search"
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(FindPlayerCell.self, forCellReuseIdentifier: "FindPlayerCell")
        }


}

extension FindPlayersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPlayers.count : players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindPlayerCell", for: indexPath) as! FindPlayerCell
        let player = isSearching ? filteredPlayers[indexPath.row] : players[indexPath.row]
        cell.configure(with: player)
        cell.delegate = self
        return cell
    }
}


extension FindPlayersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredPlayers = players
        } else {
            isSearching = true
            filteredPlayers = players.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

extension FindPlayersViewController: FindPlayerCellDelegate {
    func didTapAddButton(for user: User) {
        // Handle friend request
        let alert = UIAlertController(title: "Friend Request", message: "Friend request sent to \(user.name)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        // In real app, you would send the request to server
        // For now, just add to friends list
        if let messageVC = navigationController?.viewControllers.first as? MessageViewController {
            messageVC.addNewFriend(user)
        }
    }
}
