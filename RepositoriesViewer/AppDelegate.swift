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
        let vc = UIViewController()
        let view = RepositoriesListView()
        view.list = [RepositoryListView(title: "rep", link: "rep url"), RepositoryListView(title: "rep2", link: "rep2 url")]
        vc.view = view
            
        window.rootViewController = vc
        
        window.makeKeyAndVisible()
        return true
    }
}

