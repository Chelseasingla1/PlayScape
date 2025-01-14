//
//  CalendarViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 19/12/24.
//

import UIKit

class CalendarViewController: UIViewController {

    private let calendar = UICalendarView()
        private let eventTableView = UITableView()
        private var events: [(Date, String)] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "My Calendar"
               view.backgroundColor = .black // For dark mode theme
               setupUI()
        setupCalendar()
               setupEventTable()
               loadSampleEvents()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
           // Add your calendar UI here
           let label = UILabel()
           label.text = "Calendar View"
           label.textColor = .white
           label.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(label)
           
           NSLayoutConstraint.activate([
               label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
           ])
       }
    
    private func setupCalendar() {
            let gregorianCalendar = Calendar(identifier: .gregorian)
            let selection = UICalendarSelectionSingleDate(delegate: self)
            
            calendar.calendar = gregorianCalendar
            calendar.selectionBehavior = selection
            calendar.backgroundColor = .systemBackground
            calendar.tintColor = .systemBlue
            calendar.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(calendar)
            
            NSLayoutConstraint.activate([
                calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                calendar.heightAnchor.constraint(equalToConstant: 300)
            ])
        }
        
    private func setupEventTable() {
           eventTableView.backgroundColor = .black
           eventTableView.delegate = self
           eventTableView.dataSource = self
           eventTableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
           eventTableView.translatesAutoresizingMaskIntoConstraints = false
           
           view.addSubview(eventTableView)
           
           NSLayoutConstraint.activate([
               eventTableView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 20),
               eventTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               eventTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               eventTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }
    
    private func loadSampleEvents() {
           let today = Date()
           let calendar = Calendar.current
           
           // Sample events
           events = [
               (calendar.date(byAdding: .day, value: 1, to: today)!, "Basketball Practice - 2PM"),
               (calendar.date(byAdding: .day, value: 2, to: today)!, "Badminton Match - 4PM"),
               (calendar.date(byAdding: .day, value: 3, to: today)!, "Football Game - 6PM")
           ]
           
           eventTableView.reloadData()
       }
   
}


extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        
        let alert = UIAlertController(title: "Add Event", message: "Would you like to add an event for this date?", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Event Description"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let eventText = alert.textFields?.first?.text, !eventText.isEmpty {
                self?.events.append((date, eventText))
                self?.eventTableView.reloadData()
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
}


extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        let event = events[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        cell.textLabel?.text = "\(dateFormatter.string(from: event.0)) - \(event.1)"
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
