//
//  RegistrationViewController.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class RegistrationViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plusPhoto"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
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
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
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
        configureNotificationObservers()
    }
    
    // MARK: - Selectors
    @objc private func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    @objc private func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        
        checkFormStatus()
    }
    
    @objc private func handleRegistration() {
        guard
            let email = emailTextField.text,
            let fullname = fullnameTextField.text,
            let username = usernameTextField.text?.lowercased(),
            let password = passwordTextField.text,
            let profileImage
        else { return }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData, metadata: nil) {
            meta,
            error in
            if let error {
                print("DEBUG: Failed to upload image with error - \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL {
                url,
                error in
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) {
                    result,
                    error in
                    if let error {
                        print("DEBUG: Failed to create user with error - \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    let data = [
                        "email": email,
                        "fullname": fullname,
                        "username": username,
                        "uid": uid,
                        "profileImageUrl": profileImageUrl
                    ]
                    Firestore.firestore().collection("users").document(uid).setData(data) { error in
                        if let error {
                            print("DEBUG: Failed to upload userdata with error - \(error.localizedDescription)")
                            return
                        }
                        
                        print("DEBUG: Did create user...")
                    }
                }
            }
        }
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
    
    func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        plusPhotoButton.layer.cornerRadius = 200 / 2
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true)
    }
}

extension RegistrationViewController: AuthenticationControllerProtocol {
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        }
    }
}
