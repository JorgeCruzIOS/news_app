//
//  AppDelegate.swift
//  Newletters
//
//  Created by Jorge Alfredo Cruz Acuña on 31/10/24.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let rootCoordinator = NavigationCoordinator(window: self.window)
        rootCoordinator.start(controller: HomeView())
        return true
    }

   

}

