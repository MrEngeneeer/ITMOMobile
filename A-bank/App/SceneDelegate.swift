//
//  SceneDelegate.swift
//  A-bank
//
//  Created by Vladimir Ganetski on 10.04.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
            
        let window = UIWindow(windowScene: windowScene)
        self.coordinator = AppCoordinator(window: window)
        coordinator?.start()
        
        self.window = window

    }
}
