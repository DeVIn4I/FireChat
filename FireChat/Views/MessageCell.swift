//
//  MessageCell.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    // MARK: - Properties
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
    private let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 16)
        view.isScrollEnabled = false
        view.isEditable = false
        return view
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left: leadingAnchor, bottom: bottomAnchor, paddingLeft: 8, paddingBottom: -4)
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor)
        
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleLeftAnchor = bubbleContainer.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(textView)
        textView.anchor(
            top: bubbleContainer.topAnchor,
            left: bubbleContainer.leadingAnchor,
            bottom: bubbleContainer.bottomAnchor,
            right: bubbleContainer.trailingAnchor,
            paddingTop: 4,
            paddingLeft: 12,
            paddingBottom: 4,
            paddingRight: 12
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let message else { return }
        
        let viewModel = MessageViewModel(message: message)
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        profileImageView.isHidden = viewModel.shouldHideProfileImage
    }
    
}
