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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
            // Configure buttons
            [morningButton, dayButton, eveningButton, nightButton].forEach { button in
                button?.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
                button?.layer.cornerRadius = 12
                button?.titleLabel?.numberOfLines = 2
                button?.titleLabel?.textAlignment = .center
            }
            
            // Set button titles
            morningButton.setTitle("Morning\n(12am to 9am)", for: .normal)
            dayButton.setTitle("Day\n(9am to 4pm)", for: .normal)
            eveningButton.setTitle("Evening\n(4pm to 9pm)", for: .normal)
            nightButton.setTitle("Night\n(9pm to 12am)", for: .normal)
            
            // Setup navigation
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(cancelTapped))
        }
        
    @IBAction func timeButtonTapped(_ sender: UIButton) {
            // Reset previous selection
            selectedButton?.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            
            // Update new selection
            sender.backgroundColor = .systemGreen
            selectedButton = sender
            
            // Get button title and update
            if let title = sender.title(for: .normal) {
                delegate?.updateTime(title)
                navigationController?.popViewController(animated: true)
            }
        }
        
        @objc private func cancelTapped() {
            navigationController?.popViewController(animated: true)
        }
    

    

}
