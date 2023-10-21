//
//  LoginViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    // MARK: - Properties
    private let iconImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bubble.right")
        view.tintColor = .white
        
        return view
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        view.addSubview(iconImage)
    }
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
