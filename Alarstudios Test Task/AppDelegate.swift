//
//  AppDelegate.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 22.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        let nav = UINavigationController()
        let vc = AuthViewController()
        nav.viewControllers = [vc]
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}

