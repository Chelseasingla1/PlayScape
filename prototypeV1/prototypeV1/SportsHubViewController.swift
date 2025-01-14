//
//  SportsHubViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 12/12/24.
//

import UIKit

class SportsHubViewController: UIViewController {
    
    @IBOutlet weak var myGamesCollectionView: UICollectionView!
    @IBOutlet weak var interestCollectionView: UICollectionView!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cells once
        myGamesCollectionView.register(MyGamesCell.self, forCellWithReuseIdentifier: "MyGamesCell")
        interestCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: "InterestCell")
        gamesCollectionView.register(GamesCell.self, forCellWithReuseIdentifier: "GamesCell")
        
        title = "My Hub"
            navigationController?.navigationBar.prefersLargeTitles = true
          //  navigationController?.navigationBar.barStyle = .black // For dark mode
        setupCollectionViews()
    }
    
    private let interestItems = ["Badminton", "Basketball"]
       private let gamesItems = ["Boxing", "Badminton", "Football"]
    
    private func setupCollectionViews() {
        // Setup for My Games Collection View
        setupMyGamesCollectionView()
        
        // Setup for Interest Collection View
        setupInterestCollectionView()
        
        // Setup for Games Collection View
        setupGamesCollectionView()
        
        
        myGamesCollectionView.backgroundColor = .clear
            interestCollectionView.backgroundColor = .clear
            gamesCollectionView.backgroundColor = .clear
            
            // Enable scrolling
            myGamesCollectionView.isScrollEnabled = true
            interestCollectionView.isScrollEnabled = true
            gamesCollectionView.isScrollEnabled = true
    }
    
    private func setupMyGamesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 120)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        myGamesCollectionView.collectionViewLayout = layout
        myGamesCollectionView.delegate = self
        myGamesCollectionView.dataSource = self
        myGamesCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupInterestCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 180)
            layout.minimumInteritemSpacing = 16
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            interestCollectionView.collectionViewLayout = layout
            interestCollectionView.delegate = self
            interestCollectionView.dataSource = self
            interestCollectionView.register(InterestCell.self, forCellWithReuseIdentifier: "InterestCell")
            interestCollectionView.showsHorizontalScrollIndicator = false
        }
    
    
    private func setupGamesCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 150, height: 180)
            layout.minimumInteritemSpacing = 16
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            
            gamesCollectionView.collectionViewLayout = layout
            gamesCollectionView.delegate = self
            gamesCollectionView.dataSource = self
            gamesCollectionView.register(GamesCell.self, forCellWithReuseIdentifier: "GamesCell")
            gamesCollectionView.showsHorizontalScrollIndicator = false
        }
    
    private func showGameDetails(for game: String) {
           print("Showing details for game: \(game)")
           // You would typically push to a game details view controller here
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let gameDetailsVC = storyboard.instantiateViewController(withIdentifier: "GameDetailsViewController") as? GameDetailsViewController {
               gameDetailsVC.gameType = game
               navigationController?.pushViewController(gameDetailsVC, animated: true)
           }
       }
    
    private func showCalendar() {
           print("Showing calendar view")
           // Navigate to calendar view controller
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
               navigationController?.pushViewController(calendarVC, animated: true)
           }
       }
       
       private func showAllGames() {
           print("Showing all games")
           // Navigate to all games view controller
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let allGamesVC = storyboard.instantiateViewController(withIdentifier: "AllGamesViewController") as? AllGamesViewController {
               navigationController?.pushViewController(allGamesVC, animated: true)
           }
       }
    
}

//extension SportsHubViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case myGamesCollectionView: return 1  // Adjust based on your data
//        case interestCollectionView: return 2 // Adjust based on your data
//        case gamesCollectionView: return 3    // Adjust based on your data
//        default: return 0
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView {
//        case myGamesCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyGamesCell", for: indexPath)
//            // Configure cell
//            return cell
//            
//        case interestCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath)
//            // Configure cell
//            return cell
//            
//        case gamesCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCell", for: indexPath)
//            // Configure cell
//            return cell
//            
//        default:
//            return UICollectionViewCell()
//        }
//    }
//}

// At the bottom of SportsHubViewController.swift, after the main class implementation

extension SportsHubViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return number of items based on which collection view it is
        if collectionView == myGamesCollectionView {
            return 1  // For now, showing one game
        } else if collectionView == interestCollectionView {
            return interestItems.count
        } else {
            return gamesItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == myGamesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyGamesCell", for: indexPath) as! MyGamesCell
            
            cell.configure(
                title: "Wednesday Evening Game",
                location: "Court 1, Chitkara university",
                date: "12 Nov, Evening"
            )
//            
//            cell.viewButtonTapped = {
//                print("View button tapped for game at index: \(indexPath.item)")
//            }
            
            cell.viewButtonTapped = { [weak self] in
                      // Navigate to game details
                      self?.showGameDetails(for: "Wednesday Evening Game")
                  }
                  
                  cell.calendarButtonTapped = { [weak self] in
                      // Show calendar
                      self?.showCalendar()
                  }
            
            return cell
        }
        else if collectionView == interestCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCell", for: indexPath) as! InterestCell
            cell.configure(with: interestItems[indexPath.item])
            return cell
        }
        else {  // gamesCollectionView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCell", for: indexPath) as! GamesCell
            cell.configure(with: gamesItems[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == myGamesCollectionView {
            return CGSize(width: 300, height: 120)
        } else {
            return CGSize(width: 150, height: 180) // Size for other collection views
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == interestCollectionView {
                let game = interestItems[indexPath.item]
                showGameDetails(for: game)
            } else if collectionView == gamesCollectionView {
                let game = gamesItems[indexPath.item]
                showGameDetails(for: game)
            }
        }
}
