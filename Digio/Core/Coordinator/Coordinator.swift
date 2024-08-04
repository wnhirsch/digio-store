//
//  Coordinator.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/24.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
