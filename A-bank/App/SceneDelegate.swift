//
//  SceneDelegate.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // Создаем окно
        window = UIWindow(windowScene: windowScene)
        
        // Создаем AuthViewController
        let authViewModel = AuthViewModel()
        let authVC = AuthViewController(viewModel: authViewModel)
        
        // Устанавливаем корневой контроллер
        window?.rootViewController = authVC
        window?.makeKeyAndVisible()
    }
}
