

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Outlets
    // First Section
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var gamesCountLabel: UILabel!
    @IBOutlet weak var friendsCountLabel: UILabel!
    @IBOutlet weak var streaksCountLabel: UILabel!
    @IBOutlet weak var lastPlayedLabel: UILabel!

    // Second Section
    @IBOutlet weak var bar1View: UIView!
    @IBOutlet weak var bar1Label: UILabel!
    @IBOutlet weak var month1Label: UILabel!
    @IBOutlet weak var bar2View: UIView!
    @IBOutlet weak var bar2Label: UILabel!
    @IBOutlet weak var month2Label: UILabel!
    @IBOutlet weak var bar3View: UIView!
    @IBOutlet weak var bar3Label: UILabel!
    @IBOutlet weak var month3Label: UILabel!
    @IBOutlet weak var mysportslabel: UILabel!
    
    // Third Section
    @IBOutlet weak var leaderboardTitleLabel: UILabel!
    @IBOutlet weak var circularGraphView: UIView!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var gameListLabel: UILabel!

    // MARK: - Properties
    private let userDataModel = UserDataModel.shared
    private var currentUser: UserData? {
        didSet {
            updateUIWithUserData()
        }
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavigationBar()
        setupUI()
        loadUserData()
        
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(profileUpdated(_:)),
                                             name: NSNotification.Name("ProfileUpdated"),
                                             object: nil)
    }
    
    // MARK: - Private Methods
    private func loadUserData() {
        currentUser = userDataModel.getCurrentUser()
    }
    
    private func updateUIWithUserData() {
        guard let user = currentUser else { return }
        
        // Update profile image
        if let profileImage = UIImage(named: user.profileImage) {
            profileImageView.image = profileImage
        } else {
            profileImageView.image = UIImage(named: "profile_default")
        }
        
        // Update labels with user data
        nameLabel?.text = user.name
        universityLabel?.text = user.university
        
        // Update sports list
        let sportsText = user.sports.map { "\($0.sport.rawValue) (\($0.skillLevel.rawValue))" }
                                  .joined(separator: "\n")
        gameListLabel?.text = sportsText.isEmpty ? "No sports added" : sportsText
        
        // Update counts (you might want to add these properties to your UserData model)
        gamesCountLabel?.text = "4\nGames"  // Replace with actual data
        friendsCountLabel?.text = "20\nFriends"  // Replace with actual data
        streaksCountLabel?.text = "10\nStreaks"  // Replace with actual data
        
        // Update last played
        lastPlayedLabel?.text = "Last played: 27th November"  // Replace with actual data
    }

    private func setupUI() {
        // Set background color
        view.backgroundColor = .black

        // Profile Picture Styling
        guard let profileImageView = profileImageView else { return }
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.clipsToBounds = true

        // Style labels
        nameLabel?.numberOfLines = 0
        nameLabel?.lineBreakMode = .byWordWrapping
        nameLabel?.adjustsFontSizeToFitWidth = true
        nameLabel?.minimumScaleFactor = 0.5
        nameLabel?.textColor = .white

        universityLabel?.numberOfLines = 1
        universityLabel?.lineBreakMode = .byWordWrapping
        universityLabel?.textColor = .white

        // Style count labels
        [gamesCountLabel, friendsCountLabel, streaksCountLabel, lastPlayedLabel].forEach { label in
            label?.textColor = .white
        }

        // Bar Graph setup
        setupBarGraph(barView: bar1View, barLabel: bar1Label, barValue: 3, monthLabel: month1Label, monthText: "Sep")
        setupBarGraph(barView: bar2View, barLabel: bar2Label, barValue: 5, monthLabel: month2Label, monthText: "Oct")
        setupBarGraph(barView: bar3View, barLabel: bar3Label, barValue: 2, monthLabel: month3Label, monthText: "Nov")

        // Leaderboard setup
        leaderboardTitleLabel?.text = "Leaderboard"
        leaderboardTitleLabel?.textColor = .white

        circularGraphView?.layer.cornerRadius = (circularGraphView?.frame.width ?? 0) / 2
        circularGraphView?.layer.borderWidth = 5
        circularGraphView?.layer.borderColor = UIColor.white.cgColor

        gamesPlayedLabel?.textColor = .white
        gameListLabel?.textColor = .white
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(editProfile))
    }

    private func setupBarGraph(barView: UIView?, barLabel: UILabel?, barValue: Int, monthLabel: UILabel?, monthText: String) {
        guard let barView = barView, let barLabel = barLabel, let monthLabel = monthLabel else { return }
        barLabel.text = "\(barValue)"
        barLabel.textColor = .white
        monthLabel.text = monthText
        monthLabel.textColor = .white
        barView.backgroundColor = .blue
        barView.frame.size.height = CGFloat(barValue * 20)
    }
    
    // MARK: - Actions
    @objc private func editProfile() {
        performSegue(withIdentifier: "editProfileSegue", sender: self)
    }
    
    @objc private func profileUpdated(_ notification: Notification) {
        loadUserData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfileSegue",
           let editVC = segue.destination as? EditProfileViewController {
            editVC.currentName = currentUser?.name
            editVC.currentUniversity = currentUser?.university
            editVC.currentProfileImage = profileImageView.image
        }
    }
}
