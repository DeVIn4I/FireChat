//
//  ChatController.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import UIKit

class ChatController: UICollectionViewController {
    
    // MARK: - Properties
    private let user: User
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let view = CustomInputAccessoryView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 60))
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
    }
}
