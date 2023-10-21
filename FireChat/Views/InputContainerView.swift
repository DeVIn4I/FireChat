//
//  InputContainerView.swift
//  FireChat
//
//  Created by Razumov Pavel on 21.10.2023.
//

import UIKit

class InputContainerView: UIView {
    
    init(image: UIImage?, textField: UITextField) {
        super.init(frame: .zero)
        
        setHeight(height: 50)
        let imageView = UIImageView()
        imageView.image = image
        imageView.tintColor = .white
        imageView.alpha = 0.87
        
        addSubview(imageView)
        imageView.centerY(inView: self)
        imageView.anchor(left: leadingAnchor, paddingLeft: 8)
        imageView.setDimensions(height: 24, width: 28)
        
        addSubview(textField)
        textField.centerY(inView: self)
        textField.anchor(left: imageView.trailingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingLeft: 8, paddingBottom: -8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        addSubview(dividerView)
        dividerView.anchor(left: leadingAnchor, bottom: bottomAnchor, right: trailingAnchor, paddingLeft: 8, height: 0.75)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
