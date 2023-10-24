//
//  SceneDelegate.swift
//  FireChat
//
//  Created by Razumov Pavel on 20.10.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let navigationVC = UINavigationController(rootViewController: ConversationViewController())
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

