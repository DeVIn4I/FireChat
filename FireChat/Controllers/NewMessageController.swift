//
//  NewMessageController.swift
//  FireChat
//
//  Created by Razumov Pavel on 24.10.2023.
//

import UIKit

private let reuseId = "UserCell"

protocol NewMessageControllerDelegate: AnyObject {
    func controller(_ controller: NewMessageController, wantToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    private var users: [User] = []
    weak var delegate: NewMessageControllerDelegate?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUsers()
    }
    
    // MARK: - API
    func fetchUsers() {
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Selectors
    @objc private func handleDismissal() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureNavigationBar(title: "New message", prefersLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))

        tableView.register(UserCell.self, forCellReuseIdentifier: reuseId)
        tableView.rowHeight = 80
    }
}
// MARK: - UITableViewDataSource
extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.controller(self, wantToStartChatWith: users[indexPath.row])
    }
}
