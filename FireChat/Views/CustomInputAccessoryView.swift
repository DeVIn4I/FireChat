//
//  CustomInputAccessoryView.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import UIKit

class CustomInputAccessoryView: UIView {
    
    // MARK: - Properties
    private let messsageInputTextView: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.isScrollEnabled = false
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.systemPurple, for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top: topAnchor, right: trailingAnchor, paddingTop: 4, paddingRight: 8)
        sendButton.setDimensions(height: 50, width: 50)
        
        addSubview(messsageInputTextView)
        messsageInputTextView.anchor(
            top: topAnchor,
            left: leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            right: sendButton.leadingAnchor,
            paddingTop: 12,
            paddingLeft: 4,
            paddingBottom: 8,
            paddingRight: 8
        )
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(left: messsageInputTextView.leadingAnchor, paddingLeft: 4)
        placeholderLabel.centerY(inView: messsageInputTextView)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextInputChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    @objc private func sendMessage() {
        print(#function)
    }
    
    @objc private func handleTextInputChange() {
        placeholderLabel.isHidden = !messsageInputTextView.text.isEmpty
    }
    
    // MARK: - Helpers
    
}
