//
//  ViewDesing.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 28/10/24.
//

import Foundation
import UIKit

class ViewBuilder: UIViewController, ViewDesign{
    var navigationCoordinator : NavigationCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
        buildContraits()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = "Back"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func buildView() {
        print("build view")
        view.backgroundColor = UIColor.white
    }
    
    func buildContraits() {
        print("build contraints")
    }
    
    func injectCoordinator(coordinator: NavigationCoordinator?){
        navigationCoordinator = coordinator
    }
}

protocol ViewDesign: AnyObject{
    func buildView()
    func buildContraits()
}
