//
//  LoginViewModel.swift
//  FireChat
//
//  Created by Razumov Pavel on 22.10.2023.
//

import Foundation

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
