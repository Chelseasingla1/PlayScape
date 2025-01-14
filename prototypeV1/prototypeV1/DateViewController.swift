//
//  DateViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 12/12/24.
//

import UIKit

protocol DateViewControllerDelegate: AnyObject {
    func updateDate(_ date: String)
}

class DateViewController: UIViewController {

    @IBOutlet weak var quickDateStackView: UIStackView!
         @IBOutlet weak var todayButton: UIButton!
         @IBOutlet weak var tomorrowButton: UIButton!
         @IBOutlet weak var dayAfterButton: UIButton!
         @IBOutlet weak var calendarView: UICalendarView!
        
      //  weak var delegate: CreateGameViewController?
            private var selectedDate: Date?
    weak var delegate: DateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        [todayButton, tomorrowButton, dayAfterButton].forEach { button in
               button?.backgroundColor = .darkGray
               button?.layer.cornerRadius = 12
               button?.titleLabel?.numberOfLines = 2
               button?.titleLabel?.textAlignment = .center
           }
           
           // Set initial dates
           let today = Date()
           let calendar = Calendar.current
           
           let formatter = DateFormatter()
           formatter.dateFormat = "EEE"
           
           todayButton.setTitle("Today\n\(formatter.string(from: today))", for: .normal)
           
           if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
               tomorrowButton.setTitle("Tomorrow\n\(formatter.string(from: tomorrow))", for: .normal)
           }
           
           if let dayAfter = calendar.date(byAdding: .day, value: 2, to: today) {
               dayAfterButton.setTitle("Day After\n\(formatter.string(from: dayAfter))", for: .normal)
           }

        // Do any additional setup after loading the view.
    }
    

    private func handleQuickDateSelection(_ sender: UIButton) {
                // Reset all buttons
                [todayButton, tomorrowButton, dayAfterButton].forEach {
                    $0?.backgroundColor = .darkGray
                }
                
                // Highlight selected
                sender.backgroundColor = .systemGreen
                
                // Calculate date
                let today = Date()
                let calendar = Calendar.current
                
                switch sender {
                case todayButton:
                    selectedDate = today
                case tomorrowButton:
                    selectedDate = calendar.date(byAdding: .day, value: 1, to: today)
                case dayAfterButton:
                    selectedDate = calendar.date(byAdding: .day, value: 2, to: today)
                default:
                    break
                }
            }



        @IBAction func todayButtonTapped(_ sender: UIButton) {
               handleQuickDateSelection(sender)
           }
           
           @IBAction func tomorrowButtonTapped(_ sender: UIButton) {
               handleQuickDateSelection(sender)
           }
           
           @IBAction func dayAfterButtonTapped(_ sender: UIButton) {
               handleQuickDateSelection(sender)
           }
        
        @IBAction func cancelButtonTapped(_ sender: Any) {
                navigationController?.popViewController(animated: true)
            }
            
            @IBAction func doneButtonTapped(_ sender: Any) {
                if let date = selectedDate {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "d'th' MMMM"
                    let dateString = formatter.string(from: date)
                    delegate?.updateDate(dateString)
                }
                navigationController?.popViewController(animated: true)
            }

    
}
