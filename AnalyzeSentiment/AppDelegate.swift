//
//  AppDelegate.swift
//  AnalyzeSentiment
//
//  Created by Victor Catão on 21/03/20.
//  Copyright © 2020 Victor Catão. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootWindow()
        return true
    }
    
    // MARK: - RootWindow
    private func setupRootWindow(){
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController(viewModel: HomeViewModel()))
        self.window?.makeKeyAndVisible();
    }
    
}

