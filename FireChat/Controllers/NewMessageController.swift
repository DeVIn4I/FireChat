//
//  NewMessageController.swift
//  FireChat
//
//  Created by Razumov Pavel on 24.10.2023.
//

import UIKit

class NewMessageController: UITableViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .systemPink
    }
}
