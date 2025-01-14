//
//  AreaViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 11/12/24.
//

import UIKit
import CoreLocation

class AreaViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var tableView: UITableView!
        
        private let locationManager = CLLocationManager()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                setupLocationManager()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
            title = "Area"
            searchBar.placeholder = "Search"
            
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        private func setupLocationManager() {
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        }

}

extension AreaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath)
  cell.textLabel?.text = "Current Location using GPS"
     cell.imageView?.image = UIImage(systemName: "location")
        return cell
    }
}

extension AreaViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Handle location access denied
            print("Location access denied")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Handle location update
        print("Location: \(location)")
    }
}
