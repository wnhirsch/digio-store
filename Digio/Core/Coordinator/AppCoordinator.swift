//
//  AppCoordinator.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/24.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow
    private var navigationController = UINavigationController()
    private(set) var childCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storeCoordinator = StoreCoordinator(navigationController: navigationController)
        storeCoordinator.start()
        childCoordinator = storeCoordinator
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
