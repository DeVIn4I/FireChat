//
//  Service.swift
//  FireChat
//
//  Created by Razumov Pavel on 26.10.2023.
//

import Foundation
import Firebase

struct Service {
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard var users = snapshot?.documents.map({ User(dictionary: $0.data()) }) else { return }
            
            if let index = users.firstIndex(where: { $0.uid == Auth.auth().currentUser?.uid }) {
                users.remove(at: index)
            }
            completion(users)
        }
    }
    
    static func fetchUser(with uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchConversations(completion: @escaping([Conversation])-> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)
                
                fetchUser(with: message.chatPartnerId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, completion: ((Error?) -> Void)?) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let data = [
            "text": message,
            "fromId": currentUid,
            "toId": user.uid,
            "timestamp": Timestamp(date: Date())
        ] as [String : Any]
        
        COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
            
            COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
            
        }
    }
    
    static func fetchMessages(for user: User, completion: @escaping([Message]) -> Void) {
        var messages: [Message] = []
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timestamp")
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    
                    messages.append(Message(dictionary: dictionary))
                    completion(messages)
                }
            })
        }
    }
}
