//
//  ProfileController.swift
//  FireChat
//
//  Created by Razumov Pavel on 27.10.2023.
//

import UIKit

private let reuseId = "profileCell"

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: - API
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        
        tableView.contentInsetAdjustmentBehavior = .never
    }
}

extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}
