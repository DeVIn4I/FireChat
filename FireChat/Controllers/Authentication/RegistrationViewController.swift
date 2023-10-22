//
//  RegistrationViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plusPhoto"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var emailContainerView: InputContainerView = {
       let view = InputContainerView(image: UIImage(named: "mail"), textField: emailTextField)
        return view
    }()
    
    private lazy var fullnameContainerView: InputContainerView = {
       let view = InputContainerView(image: UIImage(named: "person"), textField: fullnameTextField)
        return view
    }()
    
    private lazy var usernameContainerView: InputContainerView = {
       let view = InputContainerView(image: UIImage(named: "person"), textField: usernameTextField)
        return view
    }()
    
    private lazy var passwordContainerView: InputContainerView = {
        let view = InputContainerView(image: UIImage(named: "lock"), textField: passwordTextField)
        return view
    }()
    
    private let emailTextField = CustomTextField(placeholder: "Email")
    private let fullnameTextField = CustomTextField(placeholder: "Full Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")

    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setHeight(height: 50)
        
        return button
    }()
    
    private lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]
        )
        attributedTitle.append(
            NSAttributedString(
                string: "Log In",
                attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white]
            )
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selectors
    @objc private func handleSelectPhoto() {
        print(#function)
    }
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .green
        configureGradientLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        let stackView = UIStackView(
            arrangedSubviews: [emailContainerView, fullnameContainerView, usernameContainerView, passwordContainerView, signUpButton]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.anchor(
            top: plusPhotoButton.bottomAnchor,
            left: view.leadingAnchor,
            right: view.trailingAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingRight: 32
        )
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(
            left: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.trailingAnchor,
            paddingLeft: 32,
            paddingRight: 32
        )
    }
}
