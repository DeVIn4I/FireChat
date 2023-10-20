//
//  ConversationViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit

private let reuseId = "ConversationCell"

class ConversationViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
        configureTableView()
    }
    // MARK: - Selectors
    
    @objc private func showProfile() {
        print("DEGUB: showProfilePressed")
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        
        let leftBarImage = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile)
        )
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemPurple
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
    }
    
}
// MARK: - UITableViewDelegate
extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Cell pressed - \(indexPath.row)")
    }

}
// MARK: - UITableViewDataSource
extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Test cell is - \(indexPath.row)"
        cell.contentConfiguration = content
        
        cell.selectionStyle = .none
        return cell
    }
    
    
}
