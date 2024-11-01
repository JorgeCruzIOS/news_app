//
//  NavigationCoordinator.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation
import UIKit


class NavigationCoordinator{
    var navigation : UINavigationController
    
    init(window : UIWindow?){
        navigation = UINavigationController()
        window?.rootViewController = self.navigation
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
    
    func start(controller: ViewBuilder){
        controller.injectCoordinator(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
    
    func present(controller: ViewBuilder){
        controller.modalPresentationStyle = .overFullScreen
        navigation.present(controller, animated: true)
    }
    
    func pop() {
        navigation.popViewController(animated: true)
    }
}
