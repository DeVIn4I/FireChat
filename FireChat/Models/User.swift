//
//  User.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import Foundation

struct User {
    let uid: String
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? "None"
        self.fullname = dictionary["fullname"] as? String ?? "None"
        self.username = dictionary["username"] as? String ?? "None"
        self.email = dictionary["email"] as? String ?? "None"
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? "None"
    }
}
