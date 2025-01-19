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
    @IBOutlet weak var datePicker: UIDatePicker!
        
      //  weak var delegate: CreateGameViewController?
            private var selectedDate: Date?
    weak var delegate: DateViewControllerDelegate?
    private let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
                setupUI()
        setupDatePicker()
        setupNavigationBar()
    }
    
    private func setupUI() {
           title = "Select Date"
           
           // Configure quick date buttons
           [todayButton, tomorrowButton, dayAfterButton].forEach { button in
               button?.backgroundColor = .darkGray
               button?.layer.cornerRadius = 12
               button?.titleLabel?.numberOfLines = 2
               button?.titleLabel?.textAlignment = .center
               button?.setTitleColor(.white, for: .normal)
           }
           
           // Set initial dates and labels
           updateQuickDateButtons()
       }
       
    
    private func setupDatePicker() {
            datePicker.datePickerMode = .date
            datePicker.preferredDatePickerStyle = .inline
            datePicker.minimumDate = Date()
            
            // Set maximum date to 3 months from now
            if let maxDate = calendar.date(byAdding: .month, value: 3, to: Date()) {
                datePicker.maximumDate = maxDate
            }
            
            // Add target for date changes
            datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        }
    
    
    @objc private func datePickerValueChanged() {
            selectedDate = datePicker.date
            
            // Reset quick date buttons
            [todayButton, tomorrowButton, dayAfterButton].forEach {
                $0?.backgroundColor = .darkGray
            }
            
            // Check if selected date matches any quick date buttons
            let today = Date()
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
            let dayAfter = calendar.date(byAdding: .day, value: 2, to: today)
            
            if calendar.isDate(datePicker.date, inSameDayAs: today) {
                todayButton.backgroundColor = .systemGreen
            } else if let tomorrow = tomorrow, calendar.isDate(datePicker.date, inSameDayAs: tomorrow) {
                tomorrowButton.backgroundColor = .systemGreen
            } else if let dayAfter = dayAfter, calendar.isDate(datePicker.date, inSameDayAs: dayAfter) {
                dayAfterButton.backgroundColor = .systemGreen
            }
        }
    
    private func setupNavigationBar() {
           navigationItem.leftBarButtonItem = UIBarButtonItem(
               title: "Cancel",
               style: .plain,
               target: self,
               action: #selector(cancelButtonTapped)
           )
           
           navigationItem.rightBarButtonItem = UIBarButtonItem(
               title: "Done",
               style: .done,
               target: self,
               action: #selector(doneButtonTapped)
           )
       }
       
    
    
    private func updateQuickDateButtons() {
            let today = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE"
            
            // Today button
            todayButton.setTitle("Today\n\(formatter.string(from: today))", for: .normal)
            
            // Tomorrow button
            if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
                tomorrowButton.setTitle("Tomorrow\n\(formatter.string(from: tomorrow))", for: .normal)
            }
            
            // Day after button
            if let dayAfter = calendar.date(byAdding: .day, value: 2, to: today) {
                dayAfterButton.setTitle("Day After\n\(formatter.string(from: dayAfter))", for: .normal)
            }
        }
        
    
    private func handleQuickDateSelection(_ sender: UIButton) {
           // Reset all buttons
           [todayButton, tomorrowButton, dayAfterButton].forEach {
               $0?.backgroundColor = .darkGray
           }
           
           // Highlight selected button
           sender.backgroundColor = .systemGreen
           
           // Calculate selected date
           let today = Date()
           
           switch sender {
           case todayButton:
               selectedDate = today
               datePicker.setDate(today, animated: true)
           case tomorrowButton:
               if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
                   selectedDate = tomorrow
                   datePicker.setDate(tomorrow, animated: true)
               }
           case dayAfterButton:
               if let dayAfter = calendar.date(byAdding: .day, value: 2, to: today) {
                   selectedDate = dayAfter
                   datePicker.setDate(dayAfter, animated: true)
               }
           default:
               break
           }
       }
    
    private func formatSelectedDate(_ date: Date) -> String {
            let formatter = DateFormatter()
            
            // Get day number
            let dayNumber = calendar.component(.day, from: date)
            
            // Get suffix for day
            let suffix: String
            switch dayNumber {
            case 1, 21, 31: suffix = "st"
            case 2, 22: suffix = "nd"
            case 3, 23: suffix = "rd"
            default: suffix = "th"
            }
            
            formatter.dateFormat = "d'\(suffix)' MMMM"
            return formatter.string(from: date)
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
                            let dateString = formatSelectedDate(date)
                            delegate?.updateDate(dateString)
                        }
                        navigationController?.popViewController(animated: true)
            }

    
}



