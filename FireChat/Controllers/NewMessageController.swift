//
//  NewMessageController.swift
//  FireChat
//
//  Created by Razumov Pavel on 24.10.2023.
//

import UIKit

private let reuseId = "UserCell"

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc private func handleDismissal() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureNavigationBar(title: "New message", prefersLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.rowHeight = 80
    }
}
// MARK: - UITableViewDataSource
extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        
        
        return cell
    }
}
