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
    
    private lazy var emailContainerView: UIView = {
       let view = UIView()
        view.setHeight(height: 50)
        view.backgroundColor = .clear
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mail")
        imageView.tintColor = .white
        
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leadingAnchor, paddingLeft: 8)
        imageView.setDimensions(height: 24, width: 24)
        
        view.addSubview(emailTextField)
        emailTextField.centerY(inView: view)
        emailTextField.anchor(left: imageView.trailingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, paddingBottom: -8)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        view.setHeight(height: 50)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lock")
        imageView.tintColor = .white
        
        view.addSubview(imageView)
        imageView.centerY(inView: view)
        imageView.anchor(left: view.leadingAnchor, paddingLeft: 8)
        imageView.setDimensions(height: 24, width: 28)
        
        view.addSubview(passwordTextField)
        passwordTextField.centerY(inView: view)
        passwordTextField.anchor(left: imageView.trailingAnchor, bottom: view.bottomAnchor, right: view.trailingAnchor, paddingLeft: 8, paddingBottom: -8)
        
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
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.placeholder = "Email"
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.placeholder = "Password"
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
