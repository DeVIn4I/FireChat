//
//  ChatController.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import UIKit

private let reuseId = "ChatCell"

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    private let user: User
    private var messages: [Message] = []
    private var fromCurrentUser = false
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let view = CustomInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 60))
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureNavigationBar(title: user.username, prefersLargeTitle: false)
        view.backgroundColor = .white
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseId)
        collectionView.alwaysBounceVertical = true
    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        
        return cell
    }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
}

extension ChatController: CustomInputAccessoryViewDelegate {
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
    
        Service.uploadMessage(message, to: user) { error in
            if let error {
                print("DEBUG: Failed to upload message with error - \(error.localizedDescription)")
                return
            }
            
            print("DEBUG: SUC....")
        }
    }
    
}
