//
//  AppDelegate.swift
//  RepositoriesViewer
//
//  Created by Admin on 05.03.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
        return true
    }
}

