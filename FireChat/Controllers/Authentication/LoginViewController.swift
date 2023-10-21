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
    
    private lazy var emailContainerView: InputContainerView = {
       let view = InputContainerView(image: UIImage(named: "mail"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        let view = InputContainerView(image: UIImage(named: "lock"), textField: passwordTextField)
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .red
        button.setHeight(height: 50)
        return button
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        return tf
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
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
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.anchor(top: iconImage.bottomAnchor, left: view.leadingAnchor,
                         right: view.trailingAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    func configureGradientLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
}
