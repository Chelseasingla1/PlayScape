//
//  SportViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit

protocol SportViewControllerDelegate: AnyObject {
    func sportSelected(_ sport: String)
}

class SportViewController: UIViewController {
    
    weak var delegate: SportViewControllerDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var collectionView: UICollectionView!
        
        private let sports = ["Basketball", "Football", "Yoga", "Swimming", "Cricket", "Hockey"]
    private var filteredSports: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI() {
            title = "Sport"
            filteredSports = sports
            
            // Configure delegates
            searchBar.delegate = self
            collectionView.delegate = self
            collectionView.dataSource = self
        }
}

extension SportViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredSports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as! SportCell
        let sport = filteredSports[indexPath.item]
        cell.sportLabel.text = sport
        cell.backgroundColor = .black
        cell.contentView.backgroundColor = .black
        
        cell.layer.cornerRadius = 10
           cell.clipsToBounds = true
        
        cell.layer.borderWidth = 1.0
           cell.layer.borderColor = UIColor.white.cgColor  // White border
        
        cell.sportImageView.image = UIImage(systemName: sport.lowercased())
        cell.sportLabel.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = filteredSports[indexPath.item]
        // Handle selection and pass back to previous screen
        delegate?.sportSelected(sport)
        navigationController?.popViewController(animated: true)
    }
}


extension SportViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSports = searchText.isEmpty ? sports : sports.filter {
            $0.lowercased().contains(searchText.lowercased())
        }
        collectionView.reloadData()
    }
}
