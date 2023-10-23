//
//  RegistrationViewModel.swift
//  FireChat
//
//  Created by Razumov Pavel on 23.10.2023.
//

import UIKit

struct RegistrationViewModel: AuthenticationProtocol {
    var email: String?
    var fullname: String?
    var username: String?
    var password: String?
//    var profileImage: UIImage?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
        && password?.isEmpty == false
        && fullname?.isEmpty == false
        && username?.isEmpty == false
    }
}
