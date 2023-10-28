//
//  ProfileController.swift
//  FireChat
//
//  Created by Razumov Pavel on 27.10.2023.
//

import UIKit
import Firebase

private let reuseId = "profileCell"

protocol ProfileControllerDelegate: AnyObject {
    func handleLogout()
}

class ProfileController: UITableViewController {
    
    // MARK: - Properties
    private lazy var headerView = ProfileHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 380))
    private let footerView = ProfileFooter()
    private var user: User? {
        didSet { headerView.user = user }
    }
    
    weak var delegate: ProfileControllerDelegate?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: - API
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        showLoader(true)
        Service.fetchUser(with: uid) { user in
            self.showLoader(false)
            self.user = user
        }
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseId)
        tableView.tableHeaderView = headerView
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = 64
        tableView.backgroundColor = .systemGroupedBackground
        footerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 100)
        tableView.tableFooterView = footerView
            
        headerView.delegate = self
        footerView.delegate = self
    }
}
// MARK: - UITableViewDataSource
extension ProfileController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProfileViewModel.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ProfileCell
        let viewModel = ProfileViewModel(rawValue: indexPath.row)
        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func dismissController() {
        dismiss(animated: true)
    }
}

extension ProfileController: ProfileFooterDelegate {
    func handleLogout() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.dismiss(animated: true) {
                self.delegate?.handleLogout()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}
// MARK: - UITableViewDelegate
extension ProfileController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let viewModel = ProfileViewModel(rawValue: indexPath.row) else { return }
    }
}
