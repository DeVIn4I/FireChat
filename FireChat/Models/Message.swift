//
//  Message.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import Foundation
import Firebase

struct Message {
    let text: String
    let toId: String
    let fromId: String
    var timestamp: Timestamp!
    var user: User?
    let isFromCurrentUser: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? "None"
        self.toId = dictionary["toId"] as? String ?? "None"
        self.fromId = dictionary["fromId"] as? String ?? "None"
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())

        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}

struct Conversation {
    let user: User
    let message: Message
}
