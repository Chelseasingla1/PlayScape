//
//  TimeViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 12/12/24.
//

import UIKit


protocol TimeViewControllerDelegate: AnyObject {
    func updateTime(_ timeSlot: String)
}

class TimeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
        @IBOutlet weak var mainStackView: UIStackView!
        @IBOutlet weak var morningButton: UIButton!
        @IBOutlet weak var dayButton: UIButton!
        @IBOutlet weak var eveningButton: UIButton!
        @IBOutlet weak var nightButton: UIButton!
        
        // MARK: - Properties
        weak var delegate: TimeViewControllerDelegate?
        private var selectedTimeSlot: String?
        private var selectedButton: UIButton?
        
    
    private let timeSlots: [(name: String, range: String)] = [
           ("Morning", "6:00 AM - 12:00 PM"),
           ("Day", "12:00 PM - 4:00 PM"),
           ("Evening", "4:00 PM - 8:00 PM"),
           ("Night", "8:00 PM - 11:00 PM")
       ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        title = "Select Time"
               
               let buttons = [morningButton, dayButton, eveningButton, nightButton]
               
               // Configure all buttons
               buttons.forEach { button in
                   button?.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
                   button?.layer.cornerRadius = 12
                   button?.titleLabel?.numberOfLines = 2
                   button?.titleLabel?.textAlignment = .center
                   button?.setTitleColor(.white, for: .normal)
                   
                   // Add shadow for better visibility
                   button?.layer.shadowColor = UIColor.black.cgColor
                   button?.layer.shadowOffset = CGSize(width: 0, height: 2)
                   button?.layer.shadowRadius = 4
                   button?.layer.shadowOpacity = 0.2
               }
               
               // Set button titles with time ranges
               morningButton.setTitle("\(timeSlots[0].name)\n\(timeSlots[0].range)", for: .normal)
               dayButton.setTitle("\(timeSlots[1].name)\n\(timeSlots[1].range)", for: .normal)
               eveningButton.setTitle("\(timeSlots[2].name)\n\(timeSlots[2].range)", for: .normal)
               nightButton.setTitle("\(timeSlots[3].name)\n\(timeSlots[3].range)", for: .normal)
               
               // Configure stack view
               mainStackView.spacing = 16
               mainStackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
               mainStackView.isLayoutMarginsRelativeArrangement = true
        }
        
    private func setupNavigationBar() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                title: "Cancel",
                style: .plain,
                target: self,
                action: #selector(cancelTapped)
            )
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Done",
                style: .done,
                target: self,
                action: #selector(doneTapped)
            )
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    
    
    private func updateSelection(with button: UIButton) {
           // Reset previous selection
           selectedButton?.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
           
           // Update new selection
           button.backgroundColor = .systemGreen
           selectedButton = button
           
           // Enable done button
           navigationItem.rightBarButtonItem?.isEnabled = true
           
           // Store selected time slot
           if let title = button.title(for: .normal) {
               selectedTimeSlot = title.components(separatedBy: "\n").first
           }
       }
    
    @IBAction func timeButtonTapped(_ sender: UIButton) {
        updateSelection(with: sender)
        }
        
        @objc private func cancelTapped() {
            navigationController?.popViewController(animated: true)
        }
    

    
     @objc private func doneTapped() {
         if let timeSlot = selectedTimeSlot {
             delegate?.updateTime(timeSlot)
         }
         navigationController?.popViewController(animated: true)
     }
    
    

}

extension TimeViewController {
    private func formatTimeRange(start: String, end: String) -> String {
        return "\(start) to \(end)"
    }
}
