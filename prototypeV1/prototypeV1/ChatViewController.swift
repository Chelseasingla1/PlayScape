//
//  ChatViewController.swift
//  prototypeV1
//
//  Created by Chelsea Singla on 10/12/24.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Properties
       var userName: String = ""
       var userImage: UIImage?
    private var messages: [ChatMessage] = []
    
    private let automatedResponses: [String: [String]] = [
           "hi": ["Hey! How are you?", "Hello! Nice to meet you!", "Hi there! How's your day going?"],
           "hello": ["Hey! How are you?", "Hello! Nice to meet you!", "Hi there! How's your day going?"],
           "how are you": ["I'm doing great, thanks for asking! How about you?", "Pretty good! How's your day going?", "I'm wonderful! How are you doing?"],
           "good morning": ["Good morning! Hope you slept well!", "Morning! Ready for a great day?", "Good morning! How's your day starting?"],
           "what's up": ["Not much, just chatting! How about you?", "Everything's good here! What's new with you?", "Just having a great day! What's happening?"],
           "bye": ["Goodbye! Have a great day!", "See you later!", "Take care! Talk to you soon!"],
           "thanks": ["You're welcome!", "No problem at all!", "Anytime!"],
           "default": ["That's interesting!", "Tell me more about that.", "I see! What else is on your mind?"]
       ]
    
       @IBOutlet weak var profileImageView: UIImageView!
       @IBOutlet weak var nameLabel: UILabel!
       @IBOutlet weak var universityLabel: UILabel!
       @IBOutlet weak var chatTableView: UITableView!
       @IBOutlet weak var messageTextField: UITextField!
       @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
                setupMessageInput()
                loadInitialMessages()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
            // Configure profile image
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
            profileImageView.clipsToBounds = true
            profileImageView.image = userImage
            
            // Configure labels
            nameLabel.text = userName
            universityLabel.text = "Chitkara University"
            
            // Configure navigation bar
            navigationItem.leftBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "chevron.left"),
                style: .plain,
                target: self,
                action: #selector(backButtonTapped)
            )
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "arrow.right.circle.fill"),
                style: .plain,
                target: self,
                action: #selector(shareButtonTapped)
            )
        
        messageTextField.placeholder = "Type a message..."
               messageTextField.delegate = self
               
               sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
               sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        
        }
        
    private func setupTableView() {
            chatTableView.delegate = self
            chatTableView.dataSource = self
            chatTableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
            chatTableView.separatorStyle = .none
            chatTableView.backgroundColor = .systemBackground
            
            // Add keyboard observers
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    private func setupMessageInput() {
            messageTextField.layer.cornerRadius = 20
            messageTextField.layer.borderWidth = 1
            messageTextField.layer.borderColor = UIColor.systemGray4.cgColor
            messageTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
            messageTextField.leftViewMode = .always
        }
        
        private func loadInitialMessages() {
            // Add some sample messages
            messages = [
                ChatMessage(content: "Hey! How are you?", isFromCurrentUser: false, timestamp: Date().addingTimeInterval(-3600)),
                ChatMessage(content: "I am fine wbu?", isFromCurrentUser: true, timestamp: Date())
            ]
            chatTableView.reloadData()
            scrollToBottom()
        }
    
    private func getAutomatedResponse(for message: String) -> String {
            let lowercasedMessage = message.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Check if we have specific responses for this message
            for (key, responses) in automatedResponses {
                if lowercasedMessage.contains(key) {
                    return responses.randomElement() ?? automatedResponses["default"]!.randomElement()!
                }
            }
            
            // If no specific response is found, return a default response
            return automatedResponses["default"]!.randomElement()!
        }
    
    private func simulateTypingAndRespond(with response: String) {
            // Add typing indicator
            let typingMessage = ChatMessage(content: "Typing...", isFromCurrentUser: false, timestamp: Date())
            messages.append(typingMessage)
            let typingIndexPath = IndexPath(row: messages.count - 1, section: 0)
            chatTableView.insertRows(at: [typingIndexPath], with: .automatic)
            scrollToBottom()
            
            // Simulate typing delay and then show the actual response
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                guard let self = self else { return }
                
                // Remove typing indicator
                self.messages.removeLast()
                
                // Add actual response
                let responseMessage = ChatMessage(content: response, isFromCurrentUser: false, timestamp: Date())
                self.messages.append(responseMessage)
                self.chatTableView.reloadData()
                self.scrollToBottom()
            }
        }
    
    
    @objc private func sendButtonTapped() {
           guard let messageText = messageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                 !messageText.isEmpty else { return }
           
           let newMessage = ChatMessage(content: messageText, isFromCurrentUser: true, timestamp: Date())
           messages.append(newMessage)
           
           messageTextField.text = ""
           
           // Insert new message cell
           let indexPath = IndexPath(row: messages.count - 1, section: 0)
           chatTableView.insertRows(at: [indexPath], with: .automatic)
           scrollToBottom()
        
        let response = getAutomatedResponse(for: messageText)
               simulateTypingAndRespond(with: response)
       }
    
    private func scrollToBottom() {
           guard !messages.isEmpty else { return }
           let indexPath = IndexPath(row: messages.count - 1, section: 0)
           chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
       }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                chatTableView.contentInset.bottom = keyboardSize.height
                chatTableView.scrollIndicatorInsets.bottom = keyboardSize.height
                scrollToBottom()
            }
        }
        
        @objc private func keyboardWillHide(notification: NSNotification) {
            chatTableView.contentInset.bottom = 0
            chatTableView.scrollIndicatorInsets.bottom = 0
        }
    
        @objc private func backButtonTapped() {
            navigationController?.popViewController(animated: true)
        }
        
        @objc private func shareButtonTapped() {
            print("Share button tapped")
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageCell") as? ChatMessageCell else {
            return UITableViewCell()
        }
        
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
}

// MARK: - UITextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendButtonTapped()
        return true
    }
}
