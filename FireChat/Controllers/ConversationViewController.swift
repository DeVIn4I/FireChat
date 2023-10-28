//
//  ConversationViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit
import Firebase

private let reuseId = "ConversationCell"

class ConversationViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private var conversations: [Conversation] = []
    private var conversationDictionary: [String: Conversation] = [:]
    
    private lazy var newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(showNewMessage), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        authenticateUser()
        fetchConversations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar(title: "Messages", prefersLargeTitle: true)
    }
    // MARK: - Selectors
    
    @objc private func showProfile() {
        let controller = ProfileController(style: .insetGrouped)
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    @objc private func showNewMessage() {
        let controller = NewMessageController()
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    // MARK: - API
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            presentLoginScreen()
        }
    }
    
    func fetchConversations() {
        showLoader(true)
        Service.fetchConversations { conversations in
            
            conversations.forEach { conversation in
                let message = conversation.message
                self.conversationDictionary[message.chatPartnerId] = conversation
            }
            self.showLoader(false)
            self.conversations = Array(self.conversationDictionary.values)
            self.tableView.reloadData()
        }
    }
    
    func presentLoginScreen() {
        DispatchQueue.main.async {
            let controller = LoginViewController()
            controller.delegate = self
            let navController = UINavigationController(rootViewController: controller)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true)
        }
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            presentLoginScreen()
        } catch let error {
            showError(error.localizedDescription)
        }
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
        configureTableView()
        
        view.addSubview(newMessageButton)
        newMessageButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.trailingAnchor,
            paddingBottom: 16,
            paddingRight: 24
        )
    }
    
    func configureTableView() {
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func showChatController(for user: User) {
        let controller = ChatController(user: user)
        navigationController?.pushViewController(controller, animated: true)
    }
}
// MARK: - UITableViewDelegate
extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = conversations[indexPath.row].user
        showChatController(for: user)
    }

}
// MARK: - UITableViewDataSource
extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - NewMessageControllerDelegate
extension ConversationViewController: NewMessageControllerDelegate {
    func controller(_ controller: NewMessageController, wantToStartChatWith user: User) {
        dismiss(animated: true)
        showChatController(for: user)
    }
}

extension ConversationViewController: ProfileControllerDelegate {
    func handleLogout() {
        logout()
    }
}

extension ConversationViewController: AuthenticationDelegate {
    func authenticationComplete() {
        dismiss(animated: true)
        configureUI()
        fetchConversations()
    }
}
