//
//  HealthSummaryViewController.swift
//  MyProfile
//
//  Created by Tanishq Malik on 22/12/24.
//

import UIKit

class HealthSummaryViewController: UITableViewController {

    @IBOutlet weak var movelabel: UILabel!
    @IBOutlet weak var stepslabel: UILabel!
    @IBOutlet weak var distancelabel: UILabel!
    @IBOutlet weak var heartratelabel: UILabel!
    @IBOutlet weak var activeEnergyLabel: UILabel!
    @IBOutlet weak var averageKcalLabel: UILabel!
    @IBOutlet weak var bloodOxygenLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        activeEnergyLabel.text = "The last 7 days you burned an average of 131 kilocalories a day."
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:  // Activity section
            return 3    // Move, Steps, Distance
        case 1:  // Heart Rate section
            return 1
        case 2:  // Active Energy section
            return 1
        case 3:  // Average kilocalories section
            return 1
        case 4:  // Blood Oxygen section
            return 1
        default:
            return 0
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    
    */
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Activity"
        case 1: return "Heart Rate"
        case 2: return "Active Energy"
        case 3: return "Average Kilocalories"
        case 4: return "Blood Oxygen"
        default: return nil
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
