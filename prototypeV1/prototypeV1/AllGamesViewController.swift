//
//  AllGamesViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 19/12/24.
//

import UIKit

class AllGamesViewController: UIViewController {

    private var gamesCollectionView: UICollectionView!
        private let games = ["Boxing", "Badminton", "Football", "Basketball", "Tennis"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "All Games"
            view.backgroundColor = .black
            setupCollectionView()
        }
    
    private func setupCollectionView() {
            // Create layout
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: (view.frame.width - 48) / 2, height: 180)
            layout.minimumInteritemSpacing = 16
            layout.minimumLineSpacing = 16
            layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 20, right: 16)
            
            // Create collection view
            gamesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            gamesCollectionView.backgroundColor = .clear
            gamesCollectionView.delegate = self
            gamesCollectionView.dataSource = self
            gamesCollectionView.register(GamesCell.self, forCellWithReuseIdentifier: "GamesCell")
            gamesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(gamesCollectionView)
            
            // Setup constraints
            NSLayoutConstraint.activate([
                gamesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                gamesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                gamesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                gamesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

}

extension AllGamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCell", for: indexPath) as! GamesCell
        cell.configure(with: games[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = games[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let gameDetailsVC = storyboard.instantiateViewController(withIdentifier: "GameDetailsViewController") as? GameDetailsViewController {
            gameDetailsVC.gameType = game
            navigationController?.pushViewController(gameDetailsVC, animated: true)
        }
    }
}
