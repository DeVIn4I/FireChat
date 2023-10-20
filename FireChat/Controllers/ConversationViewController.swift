//
//  ConversationViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit

class ConversationViewController: UIViewController {
    
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selectors
    
    @objc private func showProfile() {
        print("DEGUB: showProfilePressed")
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"
        
        let leftBarImage = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarImage,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(showProfile)
        )

        
    }
    
}

