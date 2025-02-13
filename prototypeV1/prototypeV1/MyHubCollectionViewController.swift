//
//  MyHubCollectionViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 14/01/25.
//

import UIKit

private let headerReuseIdentifier = "Header"
private let myGamesCellId = "MyGamesCell"
private let interestCellId = "InterestCell"
private let gamesCellId = "GamesCell"



class MyHubCollectionViewController: UICollectionViewController {
    
    
    var selectedGameType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadGames()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           loadGames() // Refresh data when view appears
       }
    
    private func setupCollectionView() {
           collectionView.collectionViewLayout = createCompositionalLayout()
           collectionView.register(UICollectionReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: headerReuseIdentifier)
       }
    
    private var filteredGamesData: [GameData] = []
    
    private let gameDataManager = GameDataManager.shared
    
    
    private func loadGames() {
          if let gameType = selectedGameType {
              filteredGamesData = gameDataManager.getGamesOfType(gameType)
          } else {
              filteredGamesData = gameDataManager.getAllGames()
          }
          collectionView.reloadData()
      }
      
    
    private func setupUI() {
        navigationItem.title = "My Hub"
        
        let profileButton = UIButton(type: .system)
        profileButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profileButton.tintColor = .white
        
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
    }

    @objc func profileTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "AccountModalViewController")
        
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0: // My Games section
                return self.createMyGamesSection()
            case 1: // Interest section
                return self.createInterestSection()
            case 2: // Games section
                return self.createGamesSection()
            default:
                return nil
            }
        }
    }
    
    private var gamesData: [GameData] {
        get { GameDataManager.shared.getAllGames() }
    }
    
    private func createMyGamesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(380),
                                              heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createInterestSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(0.7))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                        heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createGamesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(380),
                                              heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 10, trailing: 15)
        section.orthogonalScrollingBehavior = .groupPaging
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(30))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                               elementKind: UICollectionView.elementKindSectionHeader,
                                                               alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return myGames.count  // My Games
        case 1: return interests.count  // Interest (Multiple sports)
        case 2: return filteredGamesData.count // Games (Multiple sports)
        default: return 0
        }
    }
    
    private func configureMyGamesCell(_ cell: MyGamesCollectionViewCell, with game: (String, String, String, String)) {
           cell.dayLabel.text = game.0
           cell.dayLabel.textColor = .white
           cell.levelLabel.text = game.1
           cell.locationLabel.text = game.2
           cell.dateLabel.text = game.3
           cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
           cell.layer.cornerRadius = 12
       }
       
       private func configureInterestCell(_ cell: InterestCollectionViewCell, with interest: (String, String)) {
           cell.categoryLabel.text = interest.0
           cell.categoryLabel.textColor = .white
           cell.image.image = UIImage(named: interest.1)
           cell.layer.cornerRadius = 12
           cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0)
       }
    
    // Sample data arrays
    private let myGames = [
        ("Wednesday Evening Game", "Beginner", "Court 1, Chitkara university", "12 Nov, Evening"),
        ("Friday Morning Game", "Intermediate", "Court 2, Chitkara university", "15 Nov, Morning"),
        ("Sunday Practice", "Advanced", "Court 3, Chitkara university", "17 Nov, Evening")
    ]
    
    private let interests = [
        ("Badminton", "badminton"),
        ("Basketball", "basketball"),
        ("Cricket", "cricket"),
        ("Football", "football")
    ]
    
    private let games = [
        "boxing", "badminton", "football", "basketball", "cricket", "tennis"
    ]
    
    private func configureGamesCell(_ cell: GamesCollectionViewCell, for indexPath: IndexPath) {
           if indexPath.item < filteredGamesData.count {
               cell.configure(with: filteredGamesData[indexPath.item])
           }
       }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: myGamesCellId, for: indexPath) as! MyGamesCollectionViewCell
            let game = myGames[indexPath.item]
            configureMyGamesCell(cell, with: game)
//            cell.dayLabel.text = game.0
//            cell.dayLabel.textColor = .white
//            cell.levelLabel.text = game.1
//            cell.locationLabel.text = game.2
//            cell.dateLabel.text = game.3
//           // cell.viewButton.setTitle("VIEW", for: .normal)
//          ///  cell.viewButton.backgroundColor = UIColor.systemBlue // Blue VIEW button
//          //  cell.viewButton.layer.cornerRadius = 8
//            cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0) // Dark gray background
//            cell.layer.cornerRadius = 12
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: interestCellId, for: indexPath) as! InterestCollectionViewCell
            let interest = interests[indexPath.item]
            configureInterestCell(cell, with: interest)
//            cell.categoryLabel.text = interest.0
//            cell.categoryLabel.textColor = .white // White text
//            cell.image.image = UIImage(named: interest.1)
//            cell.layer.cornerRadius = 12
//            cell.backgroundColor = UIColor(red: 0.21, green: 0.23, blue: 0.27, alpha: 1.0) // Dark gray background
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gamesCellId, for: indexPath) as! GamesCollectionViewCell
            configureGamesCell(cell, for: indexPath)
//               if indexPath.item < gamesData.count {
//                   cell.configure(with: gamesData[indexPath.item])
//               }
               return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           switch indexPath.section {
           case 0:
               navigateToGameDetails(with: myGames[indexPath.item])
           case 1:
               navigateToGameEvents(with: interests[indexPath.item])
           case 2:
               if indexPath.item < filteredGamesData.count {
                   let game = filteredGamesData[indexPath.item]
                   navigateToGameDetails(with: (game.personName, "Intermediate", game.location ?? "", game.date ?? ""))
               }
           default:
               break
           }
       }
        

    private func setupHeaderTapGesture(header: UICollectionReusableView, section: Int) {
           // Remove any existing gesture recognizers
           header.gestureRecognizers?.forEach { header.removeGestureRecognizer($0) }
           
           // Only add gesture recognizer to Games section header
           if section == 2 {  // Games section
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gamesSectionHeaderTapped))
               header.addGestureRecognizer(tapGesture)
               header.isUserInteractionEnabled = true
               
               // Add a visual indicator that the header is tappable
               if let label = header.subviews.first as? UILabel {
                   let arrowImageView = UIImageView(image: UIImage(systemName: "chevron.right"))
                   arrowImageView.tintColor = .white
                   arrowImageView.translatesAutoresizingMaskIntoConstraints = false
                   header.addSubview(arrowImageView)
                   
                   NSLayoutConstraint.activate([
                       arrowImageView.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                       arrowImageView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -15)
                   ])
               }
           }
       }
    
    @objc private func gamesSectionHeaderTapped() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let filterVC = storyboard.instantiateViewController(withIdentifier: "GamesEventsFilterViewController") as? GamesEventsFilterViewController {
             navigationController?.pushViewController(filterVC, animated: true)
         }
     }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        
        header.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: header.frame.width - 15, height: header.frame.height))
        switch indexPath.section {
        case 0:
            label.text = "My Games"
        case 1:
            label.text = "Interest"
        case 2:
            label.text = "Games"
        default:
            break
        }
        
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        header.addSubview(label)
        
        setupHeaderTapGesture(header: header, section: indexPath.section)
        
        return header
    }
}


// MARK: - Navigation Helper Methods
extension MyHubCollectionViewController {
    private func navigateToGameDetails(with game: (String, String, String, String)) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let gameDetailsVC = storyboard.instantiateViewController(withIdentifier: "BadmintonGameViewController") as? BadmintonGameViewController {
            // Configure game details
            gameDetailsVC.gameTitle = game.0
            gameDetailsVC.gameLevel = game.1
            gameDetailsVC.gameLocation = game.2
            gameDetailsVC.gameDate = game.3
            
            // Push the view controller
            navigationController?.pushViewController(gameDetailsVC, animated: true)
        }
    }
    
    private func navigateToGameEvents(with interest: (String, String)) {
        let gameType = interest.0
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let gamesVC = storyboard.instantiateViewController(withIdentifier: "GameEventsViewController") as? GameEventsViewController {
            gamesVC.selectedGameType = gameType
            let filteredGames = gameDataManager.getGamesOfType(gameType)
            gamesVC.filteredGames = filteredGames
            navigationController?.pushViewController(gamesVC, animated: true)
        }
    }
}
