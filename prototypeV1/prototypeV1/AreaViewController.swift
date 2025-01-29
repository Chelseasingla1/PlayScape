//
//  AreaViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit
import CoreLocation

protocol AreaViewControllerDelegate: AnyObject {
    func areaSelected(_ area: String)
}


class AreaViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var tableView: UITableView!
        
        private let locationManager = CLLocationManager()
        
    weak var delegate: AreaViewControllerDelegate?
    
    
    private let locations = [
           "Downtown Sports Center",
           "Central Park",
           "Riverside Recreation Area",
           "University Sports Complex",
           "Community Center",
           "Beach Volleyball Courts",
           "City Stadium",
           "Indoor Sports Arena",
           "Fitness Park",
           "Youth Sports Center"
       ]
       
    private var filteredLocations: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                setupLocationManager()
        filteredLocations = locations
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
            title = "Area"
            searchBar.placeholder = "Search"
        
        searchBar.barStyle = .black
                searchBar.tintColor = .white
        view.backgroundColor = .black
            tableView.delegate = self
            tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LocationCell")
           
        }
        
        private func setupLocationManager() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }

}

extension AreaViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2  // Section 0 for current location, Section 1 for list of locations
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Current Location" : "Nearby Locations"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
        
        cell.backgroundColor = .black
               cell.textLabel?.textColor = .white
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Current Location using GPS"
            cell.imageView?.image = UIImage(systemName: "location.fill")
            cell.imageView?.tintColor = .white
        } else {
            let location = filteredLocations[indexPath.row]
            cell.textLabel?.text = location
            cell.imageView?.image = UIImage(systemName: "mappin.circle.fill")
            cell.imageView?.tintColor = .white 
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation: String
        if indexPath.section == 0 {
            selectedLocation = "Current Location"
        } else {
            selectedLocation = filteredLocations[indexPath.row]
        }
        
        delegate?.areaSelected(selectedLocation)
        navigationController?.popViewController(animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension AreaViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLocations = locations
        } else {
            filteredLocations = locations.filter {
                $0.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - CLLocationManagerDelegate
extension AreaViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle location access denied
            let alert = UIAlertController(
                title: "Location Access Required",
                message: "Please enable location access in Settings to use current location feature.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Handle location update - you could reverse geocode here if needed
        print("Location updated: \(location.coordinate)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
